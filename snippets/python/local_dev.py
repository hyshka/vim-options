"""Local development settings and globals."""

# ======== DATABASE CONFIGURATIONe
# See: https://docs.djangoproject.com/en/dev/ref/settings/#databases
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'jump',
        'USER': 'postgres',
        'PASSWORD': 'postgres',
        'HOST': '172.17.0.2',
        'PORT': '5432',
    }
}
# ======== END DATABASE CONFIGURATION
