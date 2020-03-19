import pytest
from freezegun import freeze_time

from icalendar import Calendar
from org_agenda import ical2org


@pytest.mark.parametrize(
    "ics, result",
    [
        pytest.param(
            """BEGIN:VCALENDAR
BEGIN:VEVENT
UID:first
SUMMARY:Feed the dragons
LOCATION:forest
DTSTART;TZID="Europe/Berlin":20200319T103000
DTEND;TZID="Europe/Berlin":20200319T113000
DESCRIPTION:take some meat
CATEGORIES:pets
END:VEVENT
END:VCALENDAR""",
            """* Feed the dragons  :pets:
:PROPERTIES:
:LOCATION: forest
:UID: first
:END:
  <2020-03-19 Thu 10:30>--<2020-03-19 Thu 11:30>
take some meat""",
            id="simple event",
        ),
        pytest.param(
            """BEGIN:VCALENDAR
BEGIN:VEVENT
DTSTART:20200319T173000Z
DTEND:20200319T181500Z
UID:second
DESCRIPTION: Search for big animals
  that are on the open
LOCATION:big forest
SUMMARY:Go hunting
BEGIN:VALARM
ACTION:DISPLAY
TRIGGER;RELATED=START:-PT15M
DESCRIPTION:Reminder
END:VALARM
END:VEVENT
END:VCALENDAR""",
            """* Go hunting
:PROPERTIES:
:LOCATION: big forest
:UID: second
:APPT_WARNTIME: 15
:END:
  <2020-03-19 Thu 18:30>--<2020-03-19 Thu 19:15>
 Search for big animals that are on the open""",
            id="Multiline description",
        ),
        pytest.param(
            """BEGIN:VEVENT
UID:fullday
SUMMARY:Home day
DTSTART;VALUE=DATE:20200312
DTEND;VALUE=DATE:20200313
END:VEVENT""",
            """* Home day
:PROPERTIES:
:UID: fullday
:END:
  <2020-03-12 Thu>""",
            id="Full day",
        ),
        pytest.param(
            """BEGIN:VEVENT
UID:forthofmonth
DTSTART;TZID=Europe/Berlin:20200125T190000
DTEND;TZID=Europe/Berlin:20200125T210000
SUMMARY:Monthly meeting
RRULE:FREQ=MONTHLY;BYDAY=WE;BYSETPOS=4
EXDATE;TZID=Europe/Berlin:20200325T190000
END:VEVENT""",
            """* Monthly meeting
:PROPERTIES:
:UID: forthofmonth
:END:
  <2020-02-26 Wed 19:00>--<2020-02-26 Wed 21:00>
  <2020-04-22 Wed 19:00>--<2020-04-22 Wed 21:00>""",
            id="repetitions 4th wed of month with exception",
        ),
        pytest.param(
            """BEGIN:VEVENT
DTSTAMP:20191226T190839Z
UID:J480MNXCKM88LL7UQ2ITQX
SUMMARY:travel
LOCATION:train
DTSTART;TZID=Europe/Berlin:20181206T190000
DURATION:PT3H
RRULE:FREQ=WEEKLY;WKST=SU;BYDAY=TH
BEGIN:VALARM
TRIGGER:-PT60M
END:VALARM
END:VEVENT
""",
            """* travel
:PROPERTIES:
:LOCATION: train
:UID: J480MNXCKM88LL7UQ2ITQX
:APPT_WARNTIME: 60
:END:
  <2020-02-20 Thu 19:00>--<2020-02-20 Thu 22:00>
  <2020-02-27 Thu 19:00>--<2020-02-27 Thu 22:00>
  <2020-03-05 Thu 19:00>--<2020-03-05 Thu 22:00>
  <2020-03-12 Thu 19:00>--<2020-03-12 Thu 22:00>
  <2020-03-19 Thu 19:00>--<2020-03-19 Thu 22:00>
  <2020-03-26 Thu 19:00>--<2020-03-26 Thu 22:00>
  <2020-04-02 Thu 19:00>--<2020-04-02 Thu 22:00>
  <2020-04-09 Thu 19:00>--<2020-04-09 Thu 22:00>
  <2020-04-16 Thu 19:00>--<2020-04-16 Thu 22:00>
  <2020-04-23 Thu 19:00>--<2020-04-23 Thu 22:00>""",
            id="duration and weekly repeat",
        ),
    ],
)
@freeze_time("2020-03-19")
def test_conversion(ics, result):
    events = "\n\n".join(ical2org.org_events([ics], 40, 30))
    print(events)
    assert events == result
