from setuptools import setup

package = "org-mode-agenda"
version = "0.1"

setup(
    name=package,
    version=version,
    packages=['org_agenda'],
    description="Import calendar agendas to Orgmode",
    entry_points={"console_scripts": ["org_agenda_sync = org_agenda:main"]},
)
