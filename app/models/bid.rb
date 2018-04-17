require "render_anywhere"
class Bid < ApplicationRecord
  include RenderAnywhere
  include ActionView::Helpers::NumberHelper

  belongs_to :request
  belongs_to :supplier
  has_many :ianswers, dependent: :destroy
  has_many :qanswers, dependent: :destroy

  def item_total
  	item_total = 0
  	self.ianswers.each do |ianswer|
  		item_total += ianswer.unit_price * ianswer.item.quantity
  	end
  	item_total
  end

  def difference_budget
    unless self.bid_budget.nil?
    	bid_budget 		  = Money.new(self.bid_budget*100, self.bid_currency)
      expected_budget = Money.new(self.request.expected_budget*100, self.request.preferred_currency)
            
      difference      = bid_budget.exchange_to(self.request.preferred_currency) - expected_budget 

      percent         = number_to_percentage( (difference/self.request.expected_budget)*100 , precision: 2).to_s 
      sprintf("%+.2f #{self.request.preferred_currency} <br>&nbsp;&nbsp;&nbsp;#{percent}", difference).html_safe

    else
      "No quote"
    end
  end

  def winner
    { request:    "##{self.request.id} #{self.request.name}",
      id:         self.id,
      name:       self.supplier.name, 
      email:      self.supplier.email, 
      company:    self.supplier.company,
      buyer:      "#{self.request.user.name}\n #{self.request.company.name}\n #{self.request.company.phone}", 
      bid_budget: "#{self.item_total} #{self.bid_currency}" }.to_json
  end

  def to_pdf
    dir = File.dirname("#{Rails.root}/public/download/#{self.request.created_at.strftime("%Y-%m-%d")}-#{self.request.name}-##{self.request.id}/Bids/#{self.supplier.company}_#{self.supplier.id}/#{self.id}/#{self.supplier.company}_#{self.request.id}_#{self.id}.pdf")
    FileUtils.mkdir_p(dir) unless File.directory?(dir)
    kit = PDFKit.new(as_html, page_size: 'A3')
    kit.to_file("#{Rails.root}/public/download/#{self.request.created_at.strftime("%Y-%m-%d")}-#{self.request.name}-##{self.request.id}/Bids/#{self.supplier.company}_#{self.supplier.id}/#{self.id}/#{self.supplier.company}_#{self.request.id}_#{self.id}.pdf")
  end

  private
  def as_html
    render template: "bids/pdf", layout: "pdf", locals: { request: self.request, bid: self }   
  end

end
