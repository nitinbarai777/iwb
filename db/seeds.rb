# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admin_user = AdminUser.find_by(email: 'admin@example.com')

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') unless admin_user.present?

puts "\n> -- Seed --------------------------"

puts "\n> -- Creating User Groups --------------------------"

user_group_1 = UserGroup.find_or_create_by!(name: "User Group 1")

user_group_2 = UserGroup.find_or_create_by!(name: "User Group 2")

puts "\n> -- Creating Users --------------------------"

test_user = User.find_by(email: "test@example.com")

unless test_user
  test_user = User.create(email: "test@example.com", first_name: "James", last_name: "Howlett", manager_id: "M123456", password: "password", password_confirmation: "password")
  test_user.user_user_groups.create(:user_group => user_group_1)
end

20.times do |i|
  email = Faker::Internet.email
  user = User.find_by(email: email)
  unless user
    user = User.create!(email: email, first_name: "#{Faker::Name.first_name}", last_name: "#{Faker::Name.first_name}", manager_id: "#{Faker::Number.number(8)}", password: "password", password_confirmation: "password")
    user.user_user_groups.create!(:user_group => (i< 10 ? user_group_1 : user_group_2))
  end
end

puts "\n> -- Creating Charts --------------------------"

12.times do |i|
  puts "\n> -- Creating Chart #{i + 1} of 12 --------------------------"
  chart_name = Faker::Lorem.word.capitalize
  chart = Chart.find_by(name: chart_name)
  unless chart
    user_group = (i< 6 ? user_group_1 : user_group_2)
    chart = Chart.create(name:chart_name, :user_group => user_group)
    user_group.users.each do |user|
      chart.chart_users.create(:user => user, :rank => "#{Faker::Number.number(4)}")
    end
  end
end

puts "\n> -- Creating Cities --------------------------"

city_1_blog_content = '<div class="container theme-showcase">
<div class="row city">
<div class="col-md-6">
<h2>Un po&#39; di storia</h2>

<p>Quisque auctor nunc at tortor semper mollis. Duis vulputate purus ut ipsum consequat lobortis non quis lectus. Nulla facilisi. Suspendisse feugiat ut lorem euismod lacinia. Quisque tempus id orci ac egestas. Proin lobortis luctus nunc non tincidunt. Quisque vestibulum commodo magna sit amet scelerisque. Fusce sed elit mattis, pellentesque dui ac, commodo ex. Curabitur rutrum, ipsum ac vulputate ornare, lorem purus auctor risus, id imperdiet urna eros sed dui. Mauris tincidunt, eros aliquam consequat elementum, mi metus accumsan libero, sed sagittis velit nunc et dui.</p>

<h2>Cosa fare</h2>

<p>Cras rhoncus auctor erat eget lacinia. Praesent sodales nec urna vel rhoncus. Curabitur in tempus risus. Nunc tempus est sem, eu tristique felis dapibus vitae. Aenean porta tortor quis mollis faucibus. Donec vel felis sapien. Duis odio nunc, fermentum sit amet placerat et, molestie sed arcu. Donec sem velit, venenatis vitae urna lacinia, suscipit convallis turpis. Nunc sagittis eleifend nunc, vel tincidunt magna tincidunt auctor. Nunc feugiat, sem quis porttitor aliquet, nisi velit facilisis mi, tristique efficitur ante metus vel est. Nullam non elit augue.</p>

<p>Cras pharetra bibendum metus, at finibus purus vulputate eu. Proin blandit eget nisl quis ornare. Aenean vel malesuada magna. Vivamus dolor est, malesuada nec lectus eget, vehicula sodales ipsum. Phasellus nec imperdiet ligula. In mollis elit eu suscipit gravida. Phasellus risus sem, ultricies ut malesuada vitae, convallis a arcu.</p>
</div>

<div class="col-md-6">
<h2>Updates</h2>

<div class="list-group">

<div style="clear:both"></div>
<a class="list-group-item" href="#">
  <img class="img-thumbnail" src="/assets/default-avatar.png">
  <h4 class="list-group-item-heading">List group item heading</h4>
  <p class="list-group-item-text small">Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit.</p>
</a>

<div style="clear:both"></div>
<a class="list-group-item" href="#">
  <img class="img-thumbnail" src="/assets/default-avatar.png">
  <h4 class="list-group-item-heading">List group item heading</h4>
  <p class="list-group-item-text small">Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit.</p>
</a>

<div style="clear:both"></div>
<a class="list-group-item" href="#">
  <img class="img-thumbnail" src="/assets/default-avatar.png">
  <h4 class="list-group-item-heading">List group item heading</h4>
  <p class="list-group-item-text small">Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit.</p>
</a>

<div style="clear:both"></div>
<a class="list-group-item" href="#">
  <img class="img-thumbnail" src="/assets/default-avatar.png">
  <h4 class="list-group-item-heading">List group item heading</h4>
  <p class="list-group-item-text small">Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit.</p>
</a>

<div style="clear:both"></div>
<a class="list-group-item" href="#">
  <img class="img-thumbnail" src="/assets/default-avatar.png">
  <h4 class="list-group-item-heading">List group item heading</h4>
  <p class="list-group-item-text small">Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit.</p>
</a>

<div style="clear:both"></div>
<a class="list-group-item" href="#">
  <img class="img-thumbnail" src="/assets/default-avatar.png">
  <h4 class="list-group-item-heading">List group item heading</h4>
  <p class="list-group-item-text small">Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit.</p>
</a>
<div style="clear:both"></div>

</div>

<div class="col-md-12">
<p><small>Per coloro che vinceranno il premio intermedio, se riusciranno ad aggiudicarsi anche la vincita della wave, avranno la possibilit&agrave; di vivere un esperienza al Top durante il viaggio formativo </small></p>
</div>
</div>
</div>
</div>
'

city_1 = City.find_by(name: "PARIGI - LONDRA")

unless city_1.present?
  City.create!(name: "PARIGI - LONDRA", blog_content: city_1_blog_content)
end

city_2_blog_content = '<div class="container">
<div class="row">
<div class="col-md-12">
<div class="card-img"><img class="card-img-top" src="http://static.panoramio.com/photos/large/19248531.jpg" />
<p>A splendid <a href="https://mobirise.com/bootstrap-gallery/">bootstrap gallery</a> is a great helper for photographers and designers, you can fill it with images and videos by adjusting properties.</p>
</div>

<div class="card-md-12">
<div class="card-img"><img class="card-img-top" src="http://photorator.com/photos/images/llyn-peris-wales-photo-by-rhys-parry-33701.jpg" /></div>

<p>Add a <a href="https://mobirise.com/responsive-menu/">responsive menu</a> to your site, it looks good on desktop devices, and they collapse on mobile devices to a hamburger icon. You can expand it to a side menu that look modern this time.</p>
</div>
</div>

<div class="col-md-12">
<p>Create an awesome <a href="https://mobirise.com/bootstrap-carousel/">bootstrap slider</a> for your site, make it look bright and live. You can use various layouts and add a color overlay.</p>
</div>

<div>&nbsp;</div>
</div>

<div class="mbr-cards-col col-xs-12 col-lg-3" style="padding-top: 40px; padding-bottom: 40px;">
<div class="container">
<div class="card cart-block">
<div class="card-img"><img class="card-img-top" src="http://i.ndtvimg.com/i/2015-12/cop21_650x400_81449887168.jpg" /></div>

<div class="card-block col-md-12">
<p>Most popular Google fonts are available in the app, and also you can add nice <a href="https://mobiriseicons.com/">free icons</a> to your buttons and menus easily. You can even use then instead of images.</p>
</div>
</div>
</div>
</div>
</div>
'

city_2 = City.find_by(name: "New York")

unless city_2.present?
  City.create!(name: "New York", blog_content: city_2_blog_content)
end

city_3_blog_content = '<div class="thumbinner">
<div class="overflowbugx" style="overflow:auto;"><a class="image" href="/wiki/File:Panama_city_panoramic_view_from_the_top_of_Ancon_hill.jpg" title="The skyline of Panama City from Ancon Hill. 2008"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Panama_city_panoramic_view_from_the_top_of_Ancon_hill.jpg/1500px-Panama_city_panoramic_view_from_the_top_of_Ancon_hill.jpg" style="height:239px; width:1500px" /></a></div>

<div class="thumbcaption">
<div class="magnify">&nbsp;</div>
The skyline of Panama City from <a href="/wiki/Ancon_Hill" title="Ancon Hill">Ancon Hill</a>. 2008</div>
</div>

<p>During World War II, construction of military bases and the presence of larger numbers of U.S. military and civilian personnel brought about unprecedented levels of prosperity to the city. Panamanians had limited access, or no access at all, to many areas in the Canal Zone neighboring the Panama city metropolitan area. Some of these areas were military bases accessible only to United States personnel. Some tensions arose between the people of Panama and the U.S. citizens living in the Panama Canal Zone. This erupted in the January 9, 1964 events, known as Martyrs&#39; Day.</p>

<div class="thumb tnone" style="margin-left: auto; margin-right:auto; overflow:hidden; width:auto; max-width:1508px;">
<div class="thumbinner">
<div class="overflowbugx" style="overflow:auto;"><a class="image" href="/wiki/File:Panama_punta_paitilla.jpg" title="Punta Paitilla view from Cinta Costera/Coastal Belt (2012)."><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/1/18/Panama_punta_paitilla.jpg/1500px-Panama_punta_paitilla.jpg" style="height:205px; width:1500px" /></a></div>

<div class="thumbcaption">
<div class="magnify">&nbsp;</div>
Punta Paitilla view from Cinta Costera/Coastal Belt (2012).</div>
</div>
</div>
'
city_3 = City.find_by(name: "Tokyo")

unless city_3.present?
  City.create!(name: "Tokyo", blog_content: city_3_blog_content)
end
