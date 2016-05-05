bundle install --path .vendor
command="bundle exec kitchen test $1-$2"
eval $command
ret_code=$?
bundle exec kitchen destroy $1-$2 || echo "Kitchen Destroy Failed"
exit $ret_code
