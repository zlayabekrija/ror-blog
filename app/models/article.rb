class Article < ApplicationRecord
    has_many :comments, dependent: :destroy
    VALID_NAME = /[\w+]/i
    validates :title, presence: true,
    length: { minimum: 5 },format: VALID_NAME
    validates :text, presence: true,
    length: { minimum: 10 },format: VALID_NAME
end
