# Builds and serves the js bundle, uploads sourcemaps and does suspect commits

# RELEASE=`../release.sh`

PACKAGE="application.monitoring.vue"
VERSION=`./release.sh`
RELEASE=$PACKAGE@$VERSION

echo $RELEASE

SENTRY_ORG=sentry
SENTRY_PROJECT=vue-test-gh
PREFIX=assets

npm run build

sentry-cli releases -o $SENTRY_ORG new -p $SENTRY_PROJECT $RELEASE
sentry-cli releases -o $SENTRY_ORG -p $SENTRY_PROJECT set-commits --auto $RELEASE
sentry-cli releases -o $SENTRY_ORG -p $SENTRY_PROJECT files $RELEASE upload-sourcemaps --url-prefix "~/assets" --validate dist/$PREFIX

serve -s dist