# -*- coding: utf-8 -*-
# Generated by Django 1.11.7 on 2017-11-20 19:32
from __future__ import unicode_literals

from django.db import migrations

SQL = """
CREATE INDEX msgs_message_org_modified_on
ON msgs_message(org_id, has_labels, modified_on, created_on DESC)
WHERE is_active = TRUE AND is_handled = TRUE;
"""


class Migration(migrations.Migration):

    atomic = False

    dependencies = [("msgs", "0058_auto_20171120_2003")]

    operations = [migrations.RunSQL(SQL), migrations.AlterIndexTogether(name="message", index_together=set([]))]
