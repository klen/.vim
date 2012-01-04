# -*- coding: utf-8 -*-

from django.db import models


class Model(models.Model):
    " Django model "

    created = models.DateTimeField(auto_now_add=True)
    active = models.BooleanField(default=True)
    name = models.CharField(max_length=100)

    class Meta():
        pass

    def __unicode__(self):
        return self.name
