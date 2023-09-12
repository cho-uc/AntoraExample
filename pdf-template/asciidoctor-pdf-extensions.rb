# coding: utf-8
require 'asciidoctor-pdf' unless defined? ::Asciidoctor::PDF

module AsciidoctorPdfExtensions
#  include ::Asciidoctor::Converter
#  include ::Asciidoctor::Writer
#  include ::Asciidoctor::Prawn::Extensions

#  ImageAttributeValueRx = /^image:{1,2}(.*?)\[(.*?)\]$/

  def layout_title_page doc
    return unless doc.header? && !doc.notitle
    super

    move_cursor_to bounds.top
    canvas do
      bounding_box [50,bounds.top-20], :width => bounds.width - 100, :height => 100 do
        theme_font :header do
          move_cursor_to bounds.top
          docnumber = ""
          revdate = ""
          releasestatus = ""

          if doc.attr? 'release-date'
            revdate = doc.attr 'release-date'
          elsif doc.attr? 'revdate'
            revdate = doc.attr 'revdate'
          else
            revdate = doc.attr 'docdate'
          end

          if doc.attr? 'document-number'
            docnumber = doc.attr 'document-number'
          else
            docnumber = doc.attr 'ERROR document-number attribute not set'
          end

          if doc.attr? 'release-status'
            releasestatus = doc.attr 'release-status'
          else
            releasestatus = doc.attr 'RESTRICTED'
          end

          layout_prose "Doc. no: " + docnumber +
                   "\nRev: " + (doc.attr 'revnumber') +
                   "\nDate: " + revdate +
                   "\nApproved By:", {
                     margin_bottom: 0,
                     margin_top: 0,
                     normalize: false}
          stroke_horizontal_rule
          move_cursor_to bounds.top
          layout_prose releasestatus, {margin_bottom: 0, margin_top: 0, align: :center}
        end
      end
    end
    
    move_cursor_to bounds.bottom
    canvas do
      bounding_box [50,50], :width => bounds.width - 100, :height => 50 do
        theme_font :footer do
          stroke_horizontal_rule
          layout_prose "© " + (doc.attr 'owner') + ", " + (doc.attr 'copyright-years') + ". Proprietary and intellectual rights of " + (doc.attr 'owner') + " are involved in the subject-matter of this material and all manufacturing, reproduction, use, disclosure and sales rights pertaining to such subject-matter are expressly reserved. This material is submitted for a specific purpose as agreed in writing, and the recipient by accepting this material agrees that this material will not be used, copied or reproduced in whole or in part, nor its content (or any part thereof) revealed in any manner or to any third party, except own staff, to meet the purpose for which it was submitted and subject to the terms of the written agreement.", {margin_bottom: 0, margin_top: 0}
        end
      end
    end
  end
end

Asciidoctor::PDF::Converter.prepend AsciidoctorPdfExtensions
