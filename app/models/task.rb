class Task < ApplicationRecord
    validates :title,:summary, presence: true
end
