# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Message.destroy_all
Channel.destroy_all
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
general_channel = Channel.create(name: Channel::BASIC_CHANNEL_NAME, workspace:)

WorkspaceUser.create(user: owner_user,
                     workspace:,
                     role: owner_role)

ChannelUser.create(user: owner_user, channel: general_channel)

WorkspaceUser.create(user: admin_user,
                     workspace:,
                     role: admin_role)

ChannelUser.create(user: admin_user, channel: general_channel)

# Define user names and emails
user_data = [
  {
    username: 'John',
    email: 'john@example.com',
    password: 'Password1!',
    password_confirmation: 'Password1!'
  },
  {
    username: 'Sarah',
    email: 'sarah@example.com',
    password: 'Password1!',
    password_confirmation: 'Password1!'
  },
  {
    username: 'Michael',
    email: 'michael@example.com',
    password: 'Password1!',
    password_confirmation: 'Password1!'
  },
  {
    username: 'Emily',
    email: 'emily@example.com',
    password: 'Password1!',
    password_confirmation: 'Password1!'
  },
  {
    username: 'David',
    email: 'david@example.com',
    password: 'Password1!',
    password_confirmation: 'Password1!'
  },
  {
    username: 'Olivia',
    email: 'olivia@example.com',
    password: 'Password1!',
    password_confirmation: 'Password1!'
  },
  {
    username: 'Daniel',
    email: 'daniel@example.com',
    password: 'Password1!',
    password_confirmation: 'Password1!'
  },
  {
    username: 'Sophia',
    email: 'sophia@example.com',
    password: 'Password1!',
    password_confirmation: 'Password1!'
  },
  {
    username: 'Matthew',
    email: 'matthew@example.com',
    password: 'Password1!',
    password_confirmation: 'Password1!'
  },
  {
    username: 'Ava',
    email: 'ava@example.com',
    password: 'Password1!',
    password_confirmation: 'Password1!'
  }
]

# Create users
users = user_data.map do |user_params|
  created_user = User.create(user_params)
  WorkspaceUser.create(user: created_user,
                       workspace:,
                       role: member_role)
  ChannelUser.create(user: created_user, channel: general_channel)
  created_user
end

users << owner_user
users << admin_user

# Define conversation snippets
conversation_snippets = [
  "Hey, how's it going? I wanted to tell you about my day. So, this morning I woke up early and went for a jog in the park. The weather was perfect, and the sunrise was stunning.",
  "Did you watch the game last night? It was such an intense match. The players gave it their all, and the score was neck and neck until the final minutes. I was on the edge of my seat the whole time.",
  "I heard there's a new restaurant opening downtown. They claim to serve the best pizza in town. I can't wait to try it out. Maybe we could go together and explore the menu.",
  "Have you seen the latest episode of that show? The plot twist at the end was mind-blowing! I never saw it coming. It's amazing how the writers manage to keep us hooked with their storytelling.",
  "I'm planning a trip next month. Any recommendations for places to visit or things to do? I want to make the most of my vacation and explore new destinations. Any hidden gems you've come across?",
  "What do you think about the new project at work? It seems like a challenging but exciting opportunity. The team has been working hard to brainstorm ideas and come up with a solid plan. I'm eager to contribute my expertise.",
  "Do you want to grab coffee sometime? We can catch up and talk about our recent experiences. I know a cozy café nearby that serves delicious pastries and has a great ambiance. Let me know when you're available.",
  "I can't believe it's already July! Time flies by so quickly. How has your year been so far? Any notable achievements or memorable events? It's always nice to reflect on our progress and cherish the moments that make life special.",
  "Did you hear about the concert happening next week? I managed to get tickets, and I'm really excited. The band is known for their energetic performances, and I'm sure it'll be an unforgettable experience. Want to join me?",
  "I need some advice. Can we chat about it? It's a personal matter, and I value your input. I've been contemplating a major life decision, and I could use a fresh perspective. Your support and insights mean a lot to me.",
  "I just finished reading an incredible book. The story was so captivating, and the characters felt so real. It's definitely worth checking out if you're looking for a new read.",
  "Guess what? I finally got that promotion I've been working towards. It's been a long journey, but the hard work paid off. I'm thrilled to take on new responsibilities and contribute to the team in a more significant way.",
  "I tried a new recipe yesterday, and it turned out amazing! It was a dish I've always wanted to attempt, and it exceeded my expectations. I'll share the recipe with you. You should give it a try too!",
  "I stumbled upon a fascinating documentary last night. It explored a subject I never thought about before, and I found it incredibly enlightening. If you're interested, I can share the details with you.",
  "I had the most incredible adventure during my vacation. I went skydiving for the first time, and the rush of adrenaline was indescribable. It's something I'll never forget, and I highly recommend trying it at least once in your life.",
  "I'm thinking about taking up a new hobby. I've always been intrigued by painting, and I feel it's time to give it a try. Do you have any tips or suggestions for a beginner?",
  "The other day, I attended a live concert, and it was absolutely mesmerizing. The atmosphere, the music, everything was perfect. It reminded me of the joy of experiencing live performances. We should plan a concert outing soon.",
  "I recently watched a thought-provoking TED Talk that made me reflect on our impact on the environment. It sparked a desire to make positive changes in my lifestyle. Let's discuss ways we can contribute to a greener future.",
  "I've been learning to play a musical instrument, and it's been quite challenging yet rewarding. It's amazing how music can bring so much joy and fulfillment. Have you ever considered learning an instrument?",
  "I visited an art gallery over the weekend, and the artwork on display was truly inspiring. It reminded me of the beauty of creativity and the power of self-expression. Let's explore the local art scene together.",
  "I went on a hiking trip last week, and the views were absolutely breathtaking. It was a challenging trail, but the sense of accomplishment at the summit made it all worthwhile. Nature has a way of rejuvenating the soul.",
  "I'm planning to volunteer at a local charity event next month. It's important to give back to the community and support those in need. If you're interested, I'd love for you to join me. Together, we can make a positive impact.",
  "I recently watched a foreign film with subtitles, and it was a delightful experience. It allowed me to explore different cultures and broaden my perspective. Sometimes, a movie can transport us to a whole new world.",
  "I attended a fascinating workshop on personal development, and it has inspired me to set new goals and work towards self-improvement. It's amazing how we can continuously learn and grow throughout our lives.",
  "I've been experimenting with photography lately. Capturing moments and memories through the lens is a creative outlet that brings me joy. I'd love to show you some of my favorite shots.",
  "I went to a comedy show last night, and it was hilarious. Laughter truly is the best medicine. We should find more opportunities to laugh and enjoy the lighter side of life.",
  "I recently started a journaling practice, and it has been incredibly therapeutic. Writing down my thoughts and experiences helps me gain clarity and reflect on my emotions. It's like having a conversation with myself.",
  "I've been exploring different cuisines and trying out new recipes in the kitchen. Cooking allows me to be creative and experiment with flavors. It's a wonderful way to express myself and share delicious meals with loved ones.",
  "I attended an inspiring conference last week, and the keynote speakers shared valuable insights and knowledge. It's empowering to learn from experts and connect with like-minded individuals. Continuous learning is a lifelong journey.",
  "I took a road trip with friends, and it was an adventure filled with laughter and unforgettable memories. Exploring new places together strengthens our bonds and creates lasting friendships.",
  "I'm passionate about sustainability and have been implementing eco-friendly practices in my daily life. Small changes can make a big difference in reducing our carbon footprint. Let's exchange ideas and tips on living more sustainably."
]

# Define conversation duration and message count
conversation_duration = 10.days
min_messages = 50
max_messages = 100

# Create conversations and messages
users.each_with_index do |sender, index|
  receiver = users[(index + 1) % users.length]
  start_time = conversation_duration.ago
  end_time = Time.current
  time_difference = (end_time - start_time).to_i

  message_count = rand(min_messages..max_messages)
  time_increment = time_difference / message_count

  current_time = start_time

  message_count.times do
    message_content = conversation_snippets.sample

    Message.create(
      author: sender,
      classifiable: general_channel,
      created_at: current_time,
      content: message_content
    )

    current_time += time_increment

    sender, receiver = receiver, sender # Swap sender and receiver for alternating messages
  end
end
