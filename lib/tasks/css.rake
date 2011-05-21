namespace :css do
  desc 'Generate CSS production files'
  task :production => :environment do
    `sass -t compressed public/stylesheets/sass/shop_list.sass public/stylesheets/shop_list.css`
    `sass -t compressed public/stylesheets/sass/mobile.sass public/stylesheets/mobile.css`
  end
end
