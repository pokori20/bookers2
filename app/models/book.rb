class Book < ApplicationRecord
   belongs_to :user

    validates :title, presence: true
    validates :body, presence: true, length: { maximum: 200}
    has_many :favorites, dependent: :destroy
    has_many :book_comments, dependent: :destroy

    def favorited_by?(user)
      favorites.where(user_id: user.id).exists?
    end
    # 完全一致
    def self.search_for(content, method)
      if method == 'perfect'
        Book.where(title: content)
        # 前方一致　モデル名.where('カラム名 like ?','検索したい文字列%')
      elsif method == 'forward'
        Book.where('title LIKE ?', content+'%')
        # 後方一致
      elsif method == 'backward'
        Book.where('title LIKE ?', '%'+content)
        # 部分一致
      else
        Book.where('title LIKE ?', '%'+content+'%')
      end
    end
    # userのcontrollerで当日と前日の投稿数を定義できるようにscope :スコープの名前, -> { 条件式 }で定義Time.zone.now.all_dayで１日　1.day.agoで昨日
    scope :created_today, -> { where(created_at: Time.zone.now.all_day) } # 今日
    scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } # 前日
    scope :created_2_day_ago, -> { where(created_at: 2.day.ago.all_day) }
    scope :created_3_day_ago, -> { where(created_at: 3.day.ago.all_day) }
    scope :created_4_day_ago, -> { where(created_at: 4.day.ago.all_day) }
    scope :created_5_day_ago, -> { where(created_at: 5.day.ago.all_day) }
    scope :created_6_day_ago, -> { where(created_at: 6.day.ago.all_day) }


    scope :created_this_week, -> { where(created_at: Time.zone.now.all_week) } #今週
    scope :created_a_week_ago, -> { where(created_at: 1.week.ago.all_day) } # 1週間前


end
