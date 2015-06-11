# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
Product.create(:title => 'The Name Of The Rose',
               :description =>"The Name of the Rose is the first novel by Italian author Umberto Eco. It is a historical murder mystery set in an Italian monastery in the year 1327, an intellectual mystery combining semiotics in fiction, biblical analysis, medieval studies and literary theory. First published in Italian in 1980 under the title  it appeared in English in 1983, translated by William Weaver..",
               :image_url =>   "/images/5.jpg",    
               :price => 42.76)
#-------
Product.create(:title => 'Before I Go To Sleep',
  :description => 
    %{<p>
        <em> A woman wakes up every day, remembering nothing as a result of a traumatic accident in her past. One day, new terrifying truths emerge that force her to question everyone around her.
      </p>},
  :image_url =>   '/images/4.jpg',    
  :price => 62.95)
#----------
Product.create(:title => 'The Day of Jackel',
  :description => 
    %{<p>
        <em> The Day of the Jackal (1971) is a thriller novel by English writer Frederick Forsyth about a professional assassin who is contracted by the OAS, a French dissident paramilitary organisation, to kill Charles de Gaulle, the President of France.

The novel received admiring reviews and praise when first published in 1971, and it received a 1972 Best Novel Edgar Award from the Mystery Writers of America. The novel remains popular, and in 2003 it was listed on the BBC's survey The Big Read.[.
      </p>},
  :image_url =>   '/images/thedayofjackel.jpg',    
  :price => 52.96)
#--------------------------------------
Product.create(:title => 'The Surgeon ',
  :description => 
    %{<p>
        <em> A terrifying new serial killer begins stalking the streets of Boston, using his vast medical knowledge to systematically torture and kill vulnerable women, a modus operandi which has earned him the nickname "the Surgeon". As Jane Rizzoli, accompanied by detective Thomas Moore, works the case, she comes across trauma doctor Catherine Cordell, who almost died in the same fashion at the hands of another psychopath several years before, but killed him before he could kill her. Rizzoli soon establishes a connection between the two cases, concluding that she may be on the trail of a deranged copycat..
      </p>},
  :image_url =>   '/images/thesurgon.jpg',    
  :price => 42.95)
#-------------------
Product.create(:title => 'Tell No One',
  :description => 
    %{<p>
        <em> Tell No One  is a 2006 French thriller film directed by Guillaume Canet and based on the novel of the same name by Harlan Coben. Written by Canet and Philippe Lefebvre and starring, the film won four categories at the 2007 Awards in France: Best Director (Guillaume Canet), Best Actor, Best Editing and Best Music Written for a Film..
      </p>},
  :image_url =>   '/images/6.jpg',    
  :price => 345.76)
#--------------------------
Product.create(:title => 'The Clokers : A Novel',
  :description => 
    %{<p>
        <em> Clockers is a 1992 novel by American author Richard Price.

The book takes place in the fictitious city of Dempsey (based on Newark and Jersey City) in North Jersey. It centers on the workings of a local drug gang and the dynamics between the drug dealers, the police and the community..
      </p>},
  :image_url =>   '/images/7.jpg',    
  :price => 142.95)