FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"
  end

  factory :admin, class: User do
    email "da@da.ru"
    password "111111"
    password_confirmation "111111"
    is_admin 1
  end

  factory :collector, class: Collector do
    ip (1 + Random.rand(256)).to_s + '.' +
         (1 + Random.rand(256)).to_s + '.' +
         (1 + Random.rand(256)).to_s + '.' +
         (1 + Random.rand(256)).to_s
    uptime Random.rand(365 * 24 * 60 * 60)
    status Random.rand(2)
    host_os [ 'GNU/Linux 2.6.32-220.4.2.el6.x86_64',
                'FreeBSD 8.1',
                'OpenBSD 5.1',
                'NetBSD 4.3'
              ].sample
    host_la '%0.2f %0.2f %0.2f' % [ 10 * Random.rand, 10 * Random.rand, 10 * Random.rand ]
    storage_used Random.rand(100)
    storage_free Random.rand(100)
    memory_used (20..30).map{ |n| 2**n }.sample
    checked_at Time.now - 1.hour
    is_blocked 0
  end

end
