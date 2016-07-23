set :environment, "development"
set :output, "/home/dat/log.log"

every "0 0 27-31 * *" do
  rake "delayjob:mailmonth"
end
