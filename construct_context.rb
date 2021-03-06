require 'json'
require './reformat_examples'

DM_BASE_IRI = "http://dataexchange.clinicalgenome.org/"

def construct_context(target = 'clingen', data_dir = File.join('data', 'flattened'))
  dmwg_examples = DMWGExampleData.new('data/flattened')
  types = dmwg_examples.types_by_entity_id
  identifier_systems = dmwg_examples.data_by_entity_type['IdentifierSystem']

  cx = {
          "base" => DM_BASE_IRI,
          "id" => "@id",
          "type" => "@type"
        }
  label = 'name'
  if target == 'sepio' then
    label = 'iri-label'
  end

  identifier_systems.each do |is|
    cx[is['prefix']] = is['urlPattern']
  end

  types.each do |id, type|
    ldid = type['iri'] && !type['iri'].include?('?') && type['iri'].split("\n").length == 1 ? type['iri'] : ""
    # only include types that have IRIs (DomainEntity, for example, is only used internally used for implementation)
    if !ldid.empty? then
      cx[type[label]] = { "@id" => ldid }
    end
    type['attributes'].each do |attrib|
      ldid = attrib['iri'] && !attrib['iri'].include?('?') && attrib['iri'].split("\n").length == 1 ? attrib['iri'] : "cg-attributes:#{attrib[label]}"
      if ['string', 'int', 'boolean', 'float'].include? attrib['dataType']
        cx[attrib[label]] = ldid
      else
        cx[attrib[label]] = { "@id" => ldid, "@type" => "@id" }
      end
    end
  end

  return { "@context" => cx }
end

if __FILE__ == $0
  print JSON.pretty_generate(construct_context())
end
