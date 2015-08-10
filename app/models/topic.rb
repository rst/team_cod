class Topic < ActiveRecord::Base
  validates :name, uniqueness: true, length: {minimum: 1, maximum: 99}

  def fancy_name
    name
      .sub(/(part|full)_time/, '\1-time')
      .sub('highschool', 'high_school')
      .split('_')
      .map(&:capitalize)
      .join(' ')
  end
end
