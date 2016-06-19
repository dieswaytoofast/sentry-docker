# encoding: utf-8
"""
Stupid script to create users in sentry from the command line
"""
from __future__ import unicode_literals
import sys

# Bootstrap the Sentry environment
from sentry.utils.runner import configure
configure()

import sentry
from sentry.models import User

username = sys.argv[1]
email = sys.argv[2]
password = sys.argv[3]

user = User.objects.create_user(username, email, password)
user.is_superuser = True
user.save()