require "render_anywhere"
class Request < ApplicationRecord
  include RenderAnywhere

  belongs_to :user
  belongs_to :company
  belongs_to :requisition
  belongs_to :folder
  has_and_belongs_to_many :suppliers
  has_and_belongs_to_many :categories
  has_many :items, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :bids, dependent: :destroy

  # validates :clarification, presence: true, :on => :update

  def winner
  	winner = nil
  	self.bids.each do |bid|
  		if bid.status == 'win'
  			winner = bid.supplier
  		end
  	end
	winner
  end

  def to_pdf
    dir = File.dirname("#{Rails.root}/public/download/#{self.created_at.strftime("%Y-%m-%d")}-#{self.name}-##{self.id}/#{self.name}.pdf")
    FileUtils.mkdir_p(dir) unless File.directory?(dir)
    kit = PDFKit.new(as_html, page_size: 'A3')
    kit.to_file("#{Rails.root}/public/download/#{self.created_at.strftime("%Y-%m-%d")}-#{self.name}-##{self.id}/#{self.name}.pdf")
  end

  private
  def as_html
    render template: "requests/pdf", layout: "pdf", locals: { request: self, bids: self.bids.where.not(status: 'reject').group_by(&:supplier) }   
  end
  
end
