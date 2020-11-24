require "wh2find/engine"

module Wh2find
  def self.get_bgrams_from text
    text = self.standardize text
    i = 0
    bgrams = []
    while i < text.length - 1 do
      bgram = text[i, 2]
      while bgrams.include? bgram
        bgram = bgram + "'"
      end
      bgrams.push bgram
      i += 1
    end
    bgrams
  end

  def self.standardize str
    accents = {
        ['á','à','â','ä','ã'] => 'a',
        ['Á','À','Ã','Ä','Â'] => 'A',
        ['é','è','ê','ë'] => 'e',
        ['Ë','É','È','Ê'] => 'E',
        ['í','ì','î','ï'] => 'i',
        ['Í','Ì','Î','Ï'] => 'I',
        ['ó','ò','ô','ö','õ'] => 'o',
        ['Õ','Ö','Ô','Ò','Ó'] => 'O',
        ['ú','ù','û','ü'] => 'u',
        ['Ú','Û','Ù','Ü'] => 'U',
        ['ç'] => 'c', ['Ç'] => 'C',
        ['ñ'] => 'n', ['Ñ'] => 'N',
    }
    accents.each do |ac,rep|
      ac.each do |s|
        str = str.gsub(s, rep)
      end
    end
    str = str.gsub(/[ \-]/,"_") # Reemplazo guión medio y espacios por guión bajo
    str = str.gsub(/[^A-Za-z0-9_]/,"") # Elimino cualquier cosa que no sea una letra, un nro o un guion
    str = str.downcase
    str = "_#{str}_"
  end
end
