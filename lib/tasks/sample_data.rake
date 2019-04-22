namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    # Create admin user
    admin = User.create!(email: "me@me.com",
                         password: "foobar",
                         password_confirmation: "foobar")
    admin.toggle!(:is_confirmed)
    admin.toggle!(:is_admin)

    # Populate users
    9.times do |n|

      email = Faker::Internet.email
      password  = "password"
      created_at = time_rand
      # User could have never logged in
      last_login_at = [ time_rand(created_at), nil ]

      User.create!(email: email,
                   password: password,
                   password_confirmation: password,
                   is_confirmed: rand(2),
                   is_blocked: rand(2),
                   created_at: created_at,
                   last_login_at: last_login_at.sample)
    end

    # Populate collectors
    10.times do |n|

      ip = (1 + rand(256)).to_s + '.' +
           (1 + rand(256)).to_s + '.' +
           (1 + rand(256)).to_s + '.' +
           (1 + rand(256)).to_s
      url_port = [ 80, 8080, 8081, 8085 ].sample
      uptime = rand(365 * 24 * 60 * 60)
      status = rand(2)
      host_os = [ 'GNU/Linux 2.6.32-220.4.2.el6.x86_64',
                  'FreeBSD 8.1',
                  'OpenBSD 5.1',
                  'NetBSD 4.3'
                ].sample
      host_la = '%0.2f %0.2f %0.2f' % [ 10 * rand, 10 * rand, 10 * rand ]
      storage_used = rand(1024 * 1024 * 1024)
      storage_free = rand(1024 * 1024 * 1024)
      memory_used = (20..30).map{ |n| 2**n }.sample
      checked_at = time_rand Time.now - 2.days
      is_blocked = rand(2)

      Collector.create!(
	      ip: ip,
        url_port: url_port,
	      uptime: uptime,
	      status: status,
	      host_os: host_os,
	      host_la: host_la,
	      storage_used: storage_used,
	      storage_free: storage_free,
	      memory_used: memory_used,
	      checked_at: checked_at,
	      is_blocked: is_blocked
      )
    end

    # Populate downloads
    5.times do |n|
      collector = Collector.first(:offset => rand(10))

      5.times do |m|
        user = User.first(:offset => rand(10))

        10.times do |l|
          # Random string generator helper
          o =  [('a'..'z'),('A'..'Z'),('0'..'9')].map{|i| i.to_a}.flatten

          url = "http://www.youtube.com/watch?v=" + (0..10).map{ o[rand(o.length)]  }.join
          status = [ 1, -1, 10].sample
          type = [ 10, 20, 30 ].sample
          title = "Video Title " + l.to_s
          author = Faker::Name.name
          length = rand(60 * 60)
          size = rand(1024 * 1024 * 1024)
          progress = 1 + rand(100)
          quality = [ "480p", "576p", "640p", "720p", "1080p" ].sample
          thumbnail =
            [ "http://img.youtube.com/vi/bQVoAWSP7k4/0.jpg",
              "http://img.youtube.com/vi/9bZkp7q19f0/0.jpg",
              "http://img.youtube.com/vi/Cqz713hhz1Y/0.jpg",
              "http://img.youtube.com/vi/tl2uU1oVRCA/0.jpg"
            ].sample
          bitrate = 1 + rand(100)

          Download.create!(
            collector: collector,
            user: user,
            url: url,
            status: status,
            type: type,
            title: title,
            author: author,
            length: length,
            size: size,
            progress: progress,
            quality: quality,
            thumbnail: thumbnail,
            bitrate: bitrate
          )
        end
      end
    end
  end
end


def time_rand from = Time.now - 6.months, to = Time.now
  Time.at(from + rand * (to.to_f - from.to_f))
end
