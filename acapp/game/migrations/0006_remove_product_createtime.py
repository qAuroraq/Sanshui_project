# Generated by Django 3.2.8 on 2022-10-26 14:54

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('game', '0005_alter_product_createtime'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='product',
            name='createtime',
        ),
    ]
