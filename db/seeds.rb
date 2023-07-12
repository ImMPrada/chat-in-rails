# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Message.destroy_all
WorkspaceChannel.destroy_all
Workspace.destroy_all
Role.destroy_all
User.destroy_all

owner_role = Role.create(name: 'owner')
admin_role = Role.create(name: 'admin')
member_role = Role.create(name: 'member')

owner_user = User.create(email: 'im.mprada+test@gmail.com',
                         password: 'Password1!',
                         password_confirmation: 'Password1!',
                         username: 'immprada.1990')

admin_user = User.create(email: 'mapra99+test@gmail.com',
                         password: 'Password1!',
                         password_confirmation: 'Password1!',
                         username: 'mapra.1999')

workspace = Workspace.create(name: 'BrodGden')
general_channel = WorkspaceChannel.create(name: 'general', workspace:)

WorkspaceUser.create(user: owner_user,
                     workspace:,
                     role: owner_role)

WorkspaceChannelUser.create(user: owner_user, workspace_channel: general_channel)

WorkspaceUser.create(user: admin_user,
                     workspace:,
                     role: admin_role)

WorkspaceChannelUser.create(user: admin_user, workspace_channel: general_channel)

10.times do
  member_user = User.create(email: Faker::Internet.email,
                            password: 'Password1!',
                            password_confirmation: 'Password1!',
                            username: Faker::Internet.username)
  WorkspaceUser.create(user: member_user,
                       workspace:,
                       role: member_role)
  WorkspaceChannelUser.create(user: member_user, workspace_channel: general_channel)
end

created_at = Date.today - 1.day
Message.create(
  author: owner_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: owner_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: admin_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: owner_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: admin_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: owner_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: admin_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: owner_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: admin_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

created_at = Date.today - 3.day
Message.create(
  author: owner_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: owner_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: admin_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: owner_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: admin_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: owner_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: admin_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: owner_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: admin_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

created_at = Date.today - 5.day
Message.create(
  author: owner_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: owner_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: admin_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: owner_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: admin_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: owner_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: admin_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: owner_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: admin_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

created_at = Date.today - 1.day
Message.create(
  author: owner_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: owner_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: admin_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: owner_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: admin_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: owner_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: admin_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: owner_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: admin_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

created_at = Date.today
Message.create(
  author: owner_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: owner_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: admin_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: owner_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: admin_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: owner_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: admin_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: owner_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)

Message.create(
  author: admin_user,
  classifiable: general_channel,
  content: Faker::Lorem.paragraph(sentence_count: (10..20).to_a.sample),
  created_at:
)