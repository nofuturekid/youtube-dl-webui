#!/usr/bin/env python
# -*- coding: utf8 -*-

from setuptools import setup

DESCRIPTION = 'webui for youtube-dl'
LONG_DESCRIPTION = 'Another webui for youtube-dl, powered by youtube-dl'

setup (
        name='youtube_dl_webui',
        version='rolling',
        packages=['youtube_dl_webui'],
        license='GPL-2.0',
        author='d0u9, yuanyingfeiyu',
        author_email='d0u9.su@outlook.com',
        description=DESCRIPTION,
        long_description=LONG_DESCRIPTION,
        include_package_data=True,
        zip_safe=False,
        install_requires=[
                'youtube-dl',
                'Flask==1.0.2',
                'Click==7.0',
                'Flask-Login==0.4.1',
                'itsdangerous==0.24',
                'Jinja2==2.10',
                'MarkupSafe==1.0',
                'Werkzeug==0.14.1',
        ],
        entry_points={
                'console_scripts': [
                        'youtube-dl-webui = youtube_dl_webui:main'
                ]
        },
)
