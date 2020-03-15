from datetime import datetime, timedelta
from pytz import utc
from dateutil.rrule import rrulestr
from dateutil import tz
from tzlocal import get_localzone

# inspiration from
# https://www.nylas.com/blog/calendar-events-rrules/


def orgdatetime(datestamp, time_zone, time=True):
    """Timezone aware datetime to YYYY-MM-DD DayofWeek HH:MM str in localtime.
    """
    hours = " %H:%M" if time else ""
    str_format = f"<%Y-%m-%d %a{hours}>"

    return datestamp.astimezone(time_zone).strftime(str_format)


def org_interval(start, duration, time_zone):
    if duration.total_seconds() % 86400 == 0:
        datestr = "  {}".format(orgdatetime(start, time_zone, False))
        if duration.total_seconds() / 86400 > 1:
            datestr += "--{}".format(
                orgdatetime(start + duration - timedelta(seconds=1), time_zone,
                            False))
        return datestr + "\n"

    return "  {}--{}\n".format(
        orgdatetime(start, time_zone),
        orgdatetime(start + duration, time_zone),
    )


def put_tz(date_time):
    if not hasattr(date_time, "hour"):
        return datetime(
            year=date_time.year,
            month=date_time.month,
            day=date_time.day,
            tzinfo=tz.tzlocal(),
        )
    return date_time.astimezone(tz.tzlocal())


class OrgEntry:
    """Documentation for OrgEntry"""
    def __init__(self, event):
        self.summary = event["SUMMARY"]
        self.dtstart = put_tz(event["DTSTART"].dt)
        if "DTEND" in event:
            self.dtend = put_tz(event["DTEND"].dt)
            self.duration = self.dtend - self.dtstart
        else:
            self.duration = event["DURATION"].dt

        self.dates = ""
        self.tags = event.get("CATEGORIES", "")
        if not isinstance(self.tags, str):
            self.tags = (self.tags.to_ical().decode("utf-8").replace(
                " ", "-").replace(",", ":"))
            self.tags = f"  :{self.tags}:"

        self.time_zone = get_localzone()
        self.properties = {}
        self._get_properties(event)
        self.description = (event["DESCRIPTION"].replace(" \n", "\n")
                            if "DESCRIPTION" in event else "")

        if "RRULE" in event:

            self.rule = rrulestr(
                event["RRULE"].to_ical().decode("utf-8"),
                dtstart=self.dtstart,
            )
        else:
            self.rule = ""

    def _get_properties(self, event):
        if "LOCATION" in event:
            self.properties.update({"location": event["LOCATION"].title()})

        for comp in event.subcomponents:
            if comp.name == 'VALARM':
                trigger = int(-1 * comp['TRIGGER'].dt.total_seconds() / 60)
                self.properties.update({'appt_warntime': str(trigger)})

    @property
    def pbox(self):
        props = "\n".join(":%s: %s" % (k.upper(), v)
                          for k, v in self.properties.items())
        if props:
            return f""":PROPERTIES:\n{props}\n:END:\n"""
        return ""

    def date_block(self, ahead=90, back=28):

        now = datetime.now(utc)
        start = now - timedelta(back)
        end = now + timedelta(ahead)

        if self.rule:
            self.dates = self.repeting_dates(start, end)

        elif self.dtstart < end and self.dtstart > start:
            self.dates = org_interval(self.dtstart, self.duration,
                                      self.time_zone)

        return self.dates

    def repeting_dates(self, start, end):

        repetitions = self.rule.between(after=start, before=end)
        return "".join(
            org_interval(event_start, self.duration, self.time_zone)
            for event_start in repetitions)

    def __str__(self):
        return (f"* {self.summary}{self.tags}\n"
                f"{self.pbox}{self.dates}{self.description}").strip()
