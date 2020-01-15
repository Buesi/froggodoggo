# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# create all profile pictures
profile_pic = ProfilePicture.create(color: 0, name: 'coffee', url: 'profile_coffee_blue_tp.png')
ProfilePicture.create(color: 1, name: 'coffee', url: 'profile_coffee_green_tp.png')
ProfilePicture.create(color: 2, name: 'coffee', url: 'profile_coffee_yellow_tp.png')
ProfilePicture.create(color: 0, name: 'culture', url: 'profile_culture_blue_tp.png')
ProfilePicture.create(color: 1, name: 'culture', url: 'profile_culture_green_tp.png')
ProfilePicture.create(color: 2, name: 'culture', url: 'profile_culture_yellow_tp.png')
ProfilePicture.create(color: 0, name: 'nature', url: 'profile_nature_blue_tp.png')
ProfilePicture.create(color: 1, name: 'nature', url: 'profile_nature_green_tp.png')
ProfilePicture.create(color: 2, name: 'nature', url: 'profile_nature_yellow_tp.png')
ProfilePicture.create(color: 0, name: 'party', url: 'profile_party_blue_tp.png')
ProfilePicture.create(color: 1, name: 'party', url: 'profile_party_green_tp.png')
ProfilePicture.create(color: 2, name: 'party', url: 'profile_party_yellow_tp.png')
ProfilePicture.create(color: 0, name: 'sports', url: 'profile_sports_blue_tp.png')
ProfilePicture.create(color: 1, name: 'sports', url: 'profile_sports_green_tp.png')
ProfilePicture.create(color: 2, name: 'sports', url: 'profile_sports_yellow_tp.png')
ProfilePicture.create(color: 0, name: 'tech', url: 'profile_tech_blue_tp.png')
ProfilePicture.create(color: 1, name: 'tech', url: 'profile_tech_green_tp.png')
ProfilePicture.create(color: 2, name: 'tech', url: 'profile_tech_yellow_tp.png')
ProfilePicture.create(color: 0, name: 'travel', url: 'profile_travel_blue_tp.png')
ProfilePicture.create(color: 1, name: 'travel', url: 'profile_travel_green_tp.png')
ProfilePicture.create(color: 2, name: 'travel', url: 'profile_travel_yellow_tp.png')
ProfilePicture.create(color: 0, name: 'vr', url: 'profile_vr_blue_tp.png')
ProfilePicture.create(color: 1, name: 'vr', url: 'profile_vr_green_tp.png')
ProfilePicture.create(color: 2, name: 'vr', url: 'profile_vr_yellow_tp.png')

# crate two founders, first user (user1) is also admin
user1 = User.create(name: 'Dorena', surname: 'Nagel', email: 'dorenanagel@gmail.com', auth0_id: 'auth0|5e0e254c8c50cd0eb7d69668', profile_picture: profile_pic)
founder1 = Founder.create(user: user1)

user2 = User.create(name: 'Dorena', surname: 'Nagel', email: 'dorena@kosmosschool.com', auth0_id: 'auth0|5dffdcb46e3d140eb0aa280a', profile_picture: profile_pic)
founder2 = Founder.create(user: user2)

# create one company and one connection to first founder
user3 = User.create(name: 'Dorena', surname: 'Nagel', email: 'dorena@gmx.ch', auth0_id: 'auth0|5e1ba00276d1ef0eb5f33a55', profile_picture: profile_pic)
company = Company.create(user: user3)

Contact.create(founder: founder1, company: company, paid: true, hire_status: 'interested')


