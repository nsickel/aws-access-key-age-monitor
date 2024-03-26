# require 'httparty'
require 'json'
require 'aws-sdk-iam'


def get_access_key_ages(iam,users)  
  users.each do |user|
    puts "Username: #{user.user_name}"
    #puts "User ARN: #{user.arn}"
    #puts "User ID: #{user.user_id}"
    puts "Created at: #{user.create_date}"
    puts "Last login: #{user.password_last_used}"
    access_keys_response = iam.list_access_keys({ user_name: user.user_name })
    access_keys = access_keys_response.access_key_metadata
    access_keys.each do |access_key|
      access_key_id = access_key.access_key_id
      access_key_craeted_at = access_key.create_date
      puts access_key_id
      puts access_key_craeted_at        
    end
    puts "-----------------------"
  end
end

def get_iam_users(iam)

  begin
    response = iam.list_users
    users = response.users
    return users
  rescue StandardError => e
    puts "Error getting IAM users: #{e.message}"
  end
end

def lambda_handler(event:, context:)
  Aws.config.update({
    region: 'eu-central-1',
    credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
  })
  #iam = Aws::IAM::Client.new
  puts "load users region #{ENV['AWS_REGION']}"
  iam = Aws::IAM::Client.new(region: ENV['AWS_REGION'])

  users = get_iam_users(iam)
  puts "users #{users}"
  get_access_key_ages(iam, users)

end