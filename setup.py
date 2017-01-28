# -*- coding: utf-8 -*-
"""
Set of python snippets
"""

from setuptools import setup, find_packages

package = 'pyutils'
version = '0.1'

setup(name=package,
      version=version,
      description="Set of python snippet for my work needs",
      packages=find_packages(),
      author="Óscar Nájera",
      author_email='najera.oscar@gmail.com',
      license="GNU General Public License v3 (GPLv3)",
      install_requires=['sympy'],
      url="https://github.com/Titan-C/helpful_scripts")
