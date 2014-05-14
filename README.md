== README

CLI to restore backup on local
gunzip -c db/backups/db_name_2014-05-14_00-30-45_dump.sql.gz | psql nytech_development

NYTech
- Add dashboard/login


// -----------------------------------------------------------------------------------------------
CODE NO LONGER IN USE:
// -----------------------------------------------------------------------------------------------

REGEX to Grab data from SRC
a.body.scan(/img.*?src="(.*?)"/i)[0][0]

// jobs -- filters.html.erb --------------------------------------------------------------------------

<div class="modal-background"></div>

<div class="filter">
		<div class="sidebar-wrapper">
		<% if current_user %>
			<%= form_for current_user, remote: true, html: { id: "job-filter-form" } do |f| %>

			
				<h1 class="department">
					My skills:
				</h1>
				<ul class="job-filters">
					<% ['Coding', 'Business', 'Marketing', 'Stragegy'].each do |dept| %>
						<% checked = dept_checked?(dept) %>
						<li class="job-sidebar department <%= 'selected' if checked %>">
								<%= label_tag dept %>
								<%= check_box_tag "user[job_settings][dept][]", dept, checked %>
							<i class="fa fa-check-circle"></i>
						</li>
					<% end %>
				</ul>
			
				<%= f.submit "Submit" %>
			<% end %>
		<% end %>
	
		<button id="clear-all">Clear All</button>
	</div>
	
</div>

div.filter {
  position: absolute;
  z-index: 9999;
  background-color: green;
  
  div.sidebar-wrapper {
    margin-top: 100px;
    margin-left: 25px;
    height: 85%;
    width: 200px;
    position: fixed;
    font-family: 'Lato', sans-serif;
    background-color: white;

    form {
      border-bottom: 2px solid rgba(0,0,0,.1);
      padding-bottom: 15px;
    }

    .search {
      padding: 14px 13px;
      border-bottom: 2px solid rgba(0,0,0,.1);
      background-color: rgba(255,255,255,.5);

      .wrapper {
        width: 170px;
        background-color: rgba(49,69,89,.1);     
        line-height: 26px;

        input {
          border: none;
          height: 20px;
          border-radius: 2px;
          width: 140px;
          color: lightgray;
          position: relative;
          top: -2px;
          margin-left: 4px;
        }

        i.fa-search {
          color: white;
          background-color: rgba(0,0,0,.35);
          line-height: 20px;
          width: 20px;
          text-align: center;
          border-radius: 2px;
          padding: 1px;
        }
      }
    }

    h1, li {
      font-size: 16px;    
    }

    h1 {
      text-indent: 15px;
      line-height: 30px;
      margin-bottom: 0px;
      color: #2c3e50;
      text-transform: uppercase; 
      background-color: #EBEBEB;

      &.department {
        cursor: pointer;
      }

      &.department i {
        font-size: 12px;
        position: relative;
        top: -2px;
        left: 32px;
      }
    }

    li {
      text-indent: 20px;
      line-height: 30px;
      color: #2c3e50;

      label {
        text-transform: capitalize;
      }

      i {
        position: absolute;
        right: 10px;
        margin-top: 7px;
        display: none;

      }

      &:hover, &.selected {
        color: rgba(255,255,255,1);
        cursor: pointer;

        i {
          display: inline-block;
          opacity: .75;
        }
      }

      &:hover {
        background-color: rgba(46, 204, 113, .5); 
      }

      &.selected {
        background-color: rgba(46, 204, 113, 1); 
        border-left: 3px solid black;
        &:hover {
          background-color: rgba(46, 204, 113, .75);         
        };
      }
    }

    #clear-all {
      border: none;
      margin-top: 20px;
      margin-left: 15px;
      height: 25px;
      width: 168px;
      border: 3px solid #7f8c8d;
      color: #2c3e50;
      background-color: #bdc3c7;
      cursor: pointer;

      &:hover {
        border: 3px solid #bdc3c7;
        color: white;
        background-color: #7f8c8d;
      };

      &:focus {
        outline: none;
      };
    }

    input[type='checkbox'], input[type='submit'] {
      display: none;
    }
  }

}

// jobs -- index.html.erb --------------------------------------------------------------------------
<!-- <div class='new-job-wrapper'>
	<%= link_to "Post a job", '#', class: 'new-job-post' %>

	<div id="file">Click to import file</div>

	<%#= form_tag import_jobs_url, multipart: true do %>
		<%= file_field_tag :file %>
		<%= submit_tag 'Import' %>
	<%# end %>
</div> -->


// _navbar.html.erb --------------------------------------------------------------------------
	
<% if flash[:welcome] %>
	<span class="coming-soon">
		<span class="wrapper"></span>
		<h1><- Coming Soon!</h1>
	</span>
<% end %>

<!-- <nav class="navbar-wrapper-two"> -->
	<%# if current_user %>
		<!-- <p>Signed in as: <%#= current_user.id %></p> -->
	<%# end %>
	<!-- <% if current_user %>
		<% if current_user.fname %>
			<h3><%= current_user.fname %>'s:</h3>
		<% else %>
			<h3>My:</h3>
		<% end %>

		<h3 class="dashboard">
			<a href='#'>Activity
				<i class="fa fa-bar-chart-o"></i>
			</a>
		</h3>
	
		<h3 class="mail"><a href='#'>
			Mail
			<i class="fa fa-envelope-o"></i>
			</a>
		</h3>
	
		<h3 class="rolodex"><a href='#'>
			Rolodex
			<i class="fa fa-barcode"></i>
			</a>
		</h3>
	
		<h3 class="profile"><a href=<%= user_url(current_user) %>>
			Profile
			<i class="fa fa-fighter-jet"></i>
			</a>
		</h3>
	<% end %>	 -->
<!-- </nav> -->

// _nav_and_section.html.erb --------------------------------------------------------------------------

<!-- THIS HARDCODED SECTIONS AND ITERATED THROUGH THEM -->
<!-- <% default_sections = { 'Join Us!' => '', 'Why Us?' => '', 'Your Role' => '', 'Day in the Life' => '', 
		'More Info' => '', "Apply Now (it's easy)!" => '' } %>
<% sections = company.career_sections.any? ? company.career_sections : default_sections %>

<div class="company-navbar">
	<% sections.each do |section_key, text_val| %>
		<% data_section = section_key.downcase.gsub(/[^a-z0-9\s]/, '').strip.gsub(/\s/, '-') %>
		<%= link_to "#{section_key}", '#', data: { company: "#{company.name}", section: "#{data_section}" }%>
	<% end %>
	
	<%= form_for company, url: add_section_company_url(company), method: :put do |f| %>
		<%= f.text_field :career_sections %>
		<%= f.submit 'Add' %>
	<% end %>
</div>

<div id="<%= company.name %>-top-id"></div>

<% sections.each do |section, text_val| %>
	<% section_class = section.downcase.gsub(/[^a-z0-9\s]/, '').strip.gsub(/\s/, '-') %>
	<div class="<%= section_class %> <%= company.name %> content hstore-type"
		contenteditable="true"
		data-table="<%= this_table %>"
		data-model="<%= this_model %>"
		data-attribute='career_sections'
		data-key="<%= section %>"
		data-id=<%= company.id %>>			
		<% section_text = add_placeholders_if_nil(section, text_val) %>
		<%= raw(section_text) %>
	</div>
<% end %> -->

<!-- THIS WAS TO ADD A NEW SECTION -->
<!-- <%= form_for company, url: add_section_company_url(company), method: :put do |f| %>
	<%= f.text_field :career_sections %>
	<%= f.submit 'Add' %>
<% end %> -->
// -----------------------------------------------------------------------------------------------


// ADMIN_JOBS.CSS>SCSS --------------------------------------------------------------------------
.pretty {
  background-color: white;
  position: relative;
  top: 100px;
  left: 100px;
  
  th {
    text-align: left;
  }
  
  th, td {
    padding: 5px;
  }
}

.pretty th .current {
  padding-right: 12px;
  background-repeat: no-repeat;
  background-position: right center;
}
.pretty th .asc { 
  background-image: url(/images/up_arrow.gif); 
}

.pretty th .desc { 
  background-image: url(/images/down_arrow.gif); 
}
// -----------------------------------------------------------------------------------------------


// WRITE TO YAML
// File.open("#{Rails.root}/app/assets/ml_data/working_knowledge.yml", 'w') { |f| f.write working.to_yaml }
// -----------------------------------------------------------------------------------------------


// PAGINATION - SHOW ON HOVER
// $('div.jobs-wrapper').on('mouseenter', function() {
//   $('.next > a').addClass('visibility-visible');
//   $('.prev > a').addClass('visibility-visible');
// })
// 
// $('div.jobs-wrapper').on('mouseleave', function() {
//   $('.next > a').removeClass('visibility-visible');
//   $('.prev > a').removeClass('visibility-visible');
// })
// -----------------------------------------------------------------------------------------------


// JOBS.JS INFINITE SCROLL -----------------------------------------------------------------------
// if ($('.pagination').length) {
//   $(window).scroll(function() {
//     var url = ($('.next a').attr('href'))
//     if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 0) {
//       $('.pagination').text('Fetching more jobs...');
//       $.getScript(url);
//     }
//   })
// }
// -----------------------------------------------------------------------------------------------


// INDEX.JS.ERB INIFINITE SCROLL
$('.job-posts').append('<%= j render(@jobs) %>');
$('.pagination').replaceWith('<%= j paginate(@jobs) %>');
// -----------------------------------------------------------------------------------------------

JS FOR CSV FILE UPLOAD -------------------------------------------------------------------------
// var wrapper = $('<div/>').css( 
//   { height: 0, width: 0, 'overflow': 'hidden' }
// );
// 
// var fileInput = $(':file').wrap(wrapper);
// 
// fileInput.change(function(){
//   $this = $(this);
//   $('#file').text($this.val());
// });
// 
// $('#file').click(function(){
//   fileInput.click();
// }).show();


//  CSV CSS
//  .new-job-wrapper {
//    border: 3px solid #ecf0f1;
//    line-height: 35px;
//    height: 30px;
//    width: 900px;
//    margin-top: 20px;
//    margin-bottom: 20px;
//    margin-left: 3px;
//    padding-right: 1px;
//    
//    a.new-job-post {
//      float: right;
//      line-height: 30px;
//      margin-right: 10px;
//    }
//    
//    div#file {
//      float: right;
//      color: gray;
//      margin-right: 100px;
//    }
//
//    form {
//      display: inline-block;
//      float: right;
//      width: 20px;
//      margin-right: -170px;
//      margin-top: -3px;
//      
//      #file {
//        display: none;
//      }
//      
//      input {
//        border: none;
//      }
//    }
//  }

// ------------------------------------------------------------------------------------



// NAVBAR.JS -------------------------------------------------------------------------
// $(document).ready(function() {
//   
//   // fix - doesn't work after second click
//   $('.coming-soon').delay(1000).fadeOut();
//   
//   $('.coming-soon-icon').on('click', function() {
//     $('.coming-soon').fadeIn().delay(1000).fadeOut();
//   });
// 
// });
// ------------------------------------------------------------------------------------


// JS FOR COMPANIES#SHOW - HSTORE DATA TYPE --------------------------------------------
// $('[contenteditable=true].article').blur(function() {
//   event.preventDefault();
//   var $id = $(this).data('id');
//   var $table = $(this).data('table');
//   var $model = $(this).data('model');
//   var $attribute = $(this).data('attribute');
//   var $newContent = $(this).html();
//   var $url = '/' + $table + '/' + $id;
//   var $key = $(this).data('key');
//   var dataObject = {};
//   
//   dataObject[$model] = {};
//   dataObject[$model][$attribute] = {}
//   dataObject[$model][$attribute][$key] = $newContent;
//   
//   $.ajax({
//     type: 'PUT',
//     url: $url,
//     data: dataObject
//   });
// });
// ------------------------------------------------------------------------------------

ORIGINAL USERS#SHOW CODE

<%#= render 'sidebar' %>

<div class="companies-wrapper">
	
	<%#= paginate @companies %>
	<div class="paper">
		
		<div class="top-wrapper">
			
			<!-- BUSINESS CARD -->
			<div class="business-card">
			  <div class="info">
			    <a href="/users/<%= @user.id %>">
			      <h1 class="name">
							<% if @user.fname && @user.lname %>
			        	<%= @user.fname.humanize %>&nbsp;<%= @user.lname.humanize %>
							<% end %>
			      </h1>
			    </a>
			    <h3 id="title"><%= @user.title %> @ <%#= @user.employer.name %></h3>
			    <h3 id="location"><%= @user.location %></h3>
			    <%= link_to "Build Profile", edit_user_url(current_user), class: 'edit' %>
			  </div>
			  <%= image_tag(@user.avatar.url) %>
			</div>
	
			<div class="paper-wrapper">
				<div class="arrow-left"></div>
				<div class="top-right"></div>
				<div class="middle-right"></div>
				<div class="bottom-right"></div>
			</div>

			<div class="bottom-left">
				
				<ul>
					<li>Overview</li>
					<li>About Me</li>
					<li>Past Work</li>
					<li>Current Work</li>
					<li>References</li>
					<li>My Rolodex</li>
					<li>Contact Me!</li>
				</ul>
				
			</div>

		</div>
		
	</div>

</div>

<div class="users-background"></div>
<div class="users-background-overlay"></div>

// ORIGINAL USER#SHOW CSS (PAPER)

div.paper {
  height: 50em;
  width: 55em;
  overflow: scroll;

  background-color: #FCFCFC;
  background-image: -webkit-linear-gradient(hsla(0,0%,0%,.025), 
    hsla(0,0%,100%,.05) 33%, hsla(0,0%,0%,.05) 33%, hsla(0,0%,100%,.05) 67%, 
    hsla(0,0%,0%,.05) 67%, hsla(0,0%,100%,.025));
//  box-shadow: inset 0 0 0 .1em hsla(0,0%,0%,.1),
//                  inset 0 0 1em hsla(0,0%,0%,.05),
//                  0 .1em .25em hsla(0,0%,0%,.5);
  position: fixed;
  left: 175px;
  top: 100px;
  padding: 15px;
  border: 1px solid rgba(0,0,0,.1);
  
  div.top-wrapper {
    width: 100%;
    height: 100%;
    
    .arrow-left {
      top: 145px;
      left: 190px;
    }
    
    .business-card {
      display: inline-block;
      float: left;
      margin-right: 0;
    }
    
    div.paper-wrapper {
      margin-left: 0px;
      height: 100%;
//      height: 215px;
      width: 695px;
      display: inline-block;
      float: right;
      background-color: rgba(189,195,199,.35);
//      padding: 15px;
      
      h1 {
        font-size: 25px;
        line-height: 30px;
        font-family: 'PT Serif', serif;
        font-weight: 900;
        color: #141510;
      }
      
      h3 {
        font-size: 20px;
        line-height: 25px;
        font-weight: 700;
        color: #555555;
        font-family: 'Lato';
      }
      
    }
    
    div.bottom-left {
      margin-top: 5px;
      height: 300%;
      width: 170px;
      display: inline-block;
      float: left;
      background-color: rgba(55,153,220,.08);
//      background-color: rgba(149, 165, 166,.1);

      ul {
        padding: 10px;
        
        li {
          line-height: 30px;
        }
      }
    }
  }
  
  div.top-right {
    position: relative;
//    background-color: rgba(50,50,50,.13);
    height: 257px;
    width: 100%;   
//    padding: 15px;
    float: right;
  }
  
  div.middle-right {
    position: relative;
//    background-color: rgba(50,50,50,.1);
    height: 280px;
    width: 100%;  
//    padding: 15px;
    float: right;
  }
  
  div.bottom-right {
    position: relative;
//    background-color: rgba(50,50,50,.05);
    height: 255px;
    width: 100%;
//    padding: 15px;
    float: right;
  }
}

.paper:after {
 right: 1000em; 
 -webkit-transform: rotate(10deg);
 -webkit-transform-origin: 100% 100%;
}

.paper:before {
  left: 1000em; 
  -webkit-transform: rotate(-10deg);
  -webkit-transform-origin: 100% 100%;
  
};

div.users-background {
  background-color: #fff;
//  opacity: .9;
  z-index: -9999;
  position: fixed;
  top: 75px;
//  background-image: url('not_in_use/grungepaper.jpg');
  height: 100%;
  width: 100%;
//  -webkit-filter: blur(1px) sepia(30%) grayscale(40%) brightness(50%);
}

.sidebar-wrapper.user {
  background-color: #FCFCFC;
}

//div.users-background-overlay {
//  z-index: -9998;
//  position: absolute;
//  top: 75px;
////  left: 250px;
//  background: url('app_images/pattern.png') repeat;   
//  height: 100%;
//  width: 100%;
//  opacity: .4;    
//}


// --------------------------------------------------------------------------------------------------------

ORIGINAL SIDEBAR CODE

<div class="sidebar-wrapper">
	
	<% if current_user %>
	
		<%= form_for current_user, remote: true, html: { id: "job-filter-form" } do |f| %>
	
			<!-- SEARCH KEYWORDS -->
			<div class="search">
				<div class="wrapper">
					<input type="search" 
								 name="user[job_settings][keywords][]" 
								 placeholder="Enter keyword" id="sidebar-search">
					<i class="fa fa-search"></i>
				</div>
			</div>
		
			<div class="sidebar-middle">
		
				<!-- KEYWORDS -->
				<div class="keywords-wrapper <%= "hidden" unless show_keywords? %>">
					<h1 class="keywords">Search Words:</h1>
					<ul class="job-filters keywords-ul">
						<% if current_user.job_settings[:keywords] %>
							<% current_user.job_settings[:keywords].each do |keyword| %>
								<li class="job-sidebar keywords-li selected">
									<%= keyword %>
									<%= check_box_tag "user[job_settings][keywords][]", keyword, checked = true %>
									<i class="fa fa-check"></i>
								</li>
							<% end %>
						<% end %>
					</ul>
				</div>
			
			
				<!-- DEPARTMENT -->
				<div class="wrapper">
					<h1 class="department">
						Department:
						<i class="fa fa-minus-circle hidden"></i>
						<i class="fa fa-plus-square-o"></i>
					</h1>
					<ul class="job-filters">
						<% Taxonomy.departments.each do |dept| %>
							<% checked = dept_checked?(dept) %>
							<li class="job-sidebar department <%= sel_or_hide(dept) %>">
									<%= label_tag dept %>
									<%= check_box_tag "user[job_settings][dept][]", dept, checked  %>
								<i class="fa fa-check"></i>
							</li>
						<% end %>
					</ul>
				</div>
		
				<!-- SUB DEPT -->	
				<div class="wrapper">
					<h1 class="sub_dept <%= "hidden" unless return_sub_depts.any? %>">
						Role:
						<i class="fa fa-minus-circle department hidden"></i>
						<i class="fa fa-plus-square-o department"></i>
					</h1>
					<ul class="job-filters">
						<% return_sub_depts.each do |sub| %>
							<% checked = sub_dept_checked?(sub) %>
							<li class="job-sidebar <%= checked ? 'selected' : 'hidden' %>">
								<%= label_tag sub %>
								<%= check_box_tag "user[job_settings][sub_dept][]", sub, checked %>
								<i class="fa fa-check sub_dept"></i>
							</li>
						<% end %>
					</ul>
				</div>	
			
				<!-- EXPERIENCE -->	
				<% if current_user.job_settings[:dept] %>
					<div class="wrapper">
						<h1 class="experience">
							Experience (Yrs):
							<i class="fa fa-minus-circle hidden"></i>
							<i class="fa fa-plus-square-o"></i>
						</h1>
						<ul class="job-filters">
							<% [['Internship', 0],
									['Entry (0-1)', 1], 
									['Junior (1-2)', 2], 
									['Mid (2-3)', 3], 
									['Experienced (3-5+)', 5], 
									['Veteran (5+)', 8],
									['Exec (10+)', 10]].each do |label, num_years| %>
								<% checked = num_years_checked?(num_years) %>
								<li class="job-sidebar <%= checked ? 'selected' : 'hidden' %>">
									<%= label_tag "#{label}-#{label}", label %>
									<%= check_box_tag "user[job_settings][experience][]", num_years, checked %>
									<i class="fa fa-check"></i>
								</li>
							<% end %>
						</ul>
					</div>
				<% end %>
			
				<!-- KEY SKILLS -->				
				<% if current_user.job_settings[:sub_dept] %>
					<div class="wrapper">
						<h1 class="key-skills">
							Key Skills:
							<i class="fa fa-minus-circle"></i>
							<i class="fa fa-plus-square-o hidden"></i>
						</h1>
						<ul class="job-filters key-skills">
							<% Taxonomy.front_end_key_skills.each_with_index do |skill, index| %>
								<div class="key-skills-wrapper">
									<li class="job-sidebar key-skills">
										<%= label_tag skill %>
									</li>
							
									<div class="degree-wrapper">
										<% Taxonomy.key_skill_degrees[index].each do |degree| %>
											<% checked = key_skill_checked?(degree) %>
											<li class="degree <%= 'selected' if checked %>">
												<%= label_tag degree %>
												<%= check_box_tag "user[job_settings][key_skills][]", degree, checked %>
											</li>
										<% end %>
									</div>
								</div>
							<% end %>
						</ul>
					</div>
				<% end %>
			
			
				<%= f.submit "Submit" %>
			<% end %>
			
		</div>
	
		<div class="clear">
			<button id="clear-all">Clear All</button>
		</div>

	<% end %>
	
</div>



// ORIGINAL JS FOR FLIPS.JS -----------------------------------------------------------

Comment: this was the raw flips.js file before reformatting

/**
 * jquery.flips.js
 * 
 * Copyright 2011, Pedro Botelho / Codrops
 * Free to use under the MIT license.
 *
 * Date: Fri May 4 2012
 */
 
/**
 * Note: This is highly experimental and just a proof-of-concept! 
 * There are some few "hacks", probably some bugs, and some functionality 
 * is incomplete... definitely not ready for a production environment.
 *
 *
 * Tested and working on:
 * - Google Chrome 18.0.1025.168
 * - Apple Safari 5.1.5
 * - Apple Safari 5.1 Mobile
 * 
 */

(function( window, undefined ) {
  
	$.Flips 			= function( options, element ) {
	
		this.$el	= $( element );
		this._init( options );
		
	};
	
	$.Flips.defaults 	= {
		flipspeed			: 900,
		fliptimingfunction	: 'linear',
		current				: 0
	};
	
	$.Flips.prototype 	= {
		_init 				: function( options ) {
			
			this.options 		= $.extend( true, {}, $.Flips.defaults, options );
			this.$pages			= this.$el.children( 'div.f-page' );
			this.pagesCount		= this.$pages.length;
			this.History		= window.History;
			this.currentPage	= this.options.current;
			this._validateOpts();
			this._getWinSize();
			this._getState();
			this._layout();
			this._initTouchSwipe();
			this._loadEvents();
			this._goto();
			
		},
		_validateOpts		: function() {
			
			if( this.currentPage < 0 || this.currentPage > this.pagesCount ) {
			
				this.currentPage = 0;
			
			}
		
		},
		_getWinSize			: function() {
			
			var $win = $( window );
			
			this.windowProp = {
				width	: $win.width(),
				height	: $win.height()
			};
		
		},
		_goto				: function() {
			
			var page = ( this.state === undefined ) ? this.currentPage : this.state;
			
			if( !this._isNumber( page ) || page < 0 || page > this.flipPagesCount ) {
			
				page = 0;
			
			}
			
			this.currentPage = page;
			
		},
		_getState			: function() {
		
			this.state = this.History.getState().url.queryStringToJSON().page;
			
		},
		_isNumber			: function( n ) {
		
			return parseFloat( n ) == parseInt( n ) && !isNaN( n ) && isFinite( n );
		
		},
		_adjustLayout		: function( page ) {
		
			var _self = this;
			
			this.$flipPages.each( function( i ) {
				
				var $page	= $(this);
				
				if( i === page - 1 ) {
				
					$page.css({
						'-webkit-transform'	: 'rotateY( -180deg )',
						'-moz-transform'	: 'rotateY( -180deg )',
						'z-index'			: _self.flipPagesCount - 1 + i
					});
				
				}
				else if( i < page ) {
				
					$page.css({
						'-webkit-transform'	: 'rotateY( -181deg )', // todo: fix this (should be -180deg)
						'-moz-transform'	: 'rotateY( -181deg )', // todo: fix this (should be -180deg)
						'z-index'			: _self.flipPagesCount - 1 + i
					});
				
				}
				else {
				
					$page.css({
						'-webkit-transform'	: 'rotateY( 0deg )',
						'-moz-transform'	: 'rotateY( 0deg )',
						'z-index'			: _self.flipPagesCount - 1 - i
					});
				
				}
						
			} );
		
		},
		_saveState			: function() {
		
			// adds a new state to the history object and triggers the statechange event on the window
			var page = this.currentPage;
			
			if( this.History.getState().url.queryStringToJSON().page !== page ) {
					
				this.History.pushState( null, null, '?page=' + page );
				
			}
			
		},
		_layout				: function() {
			
			this._setLayoutSize();
			
			for( var i = 0; i <= this.pagesCount - 2; ++i ) {
				
				var	$page 		= this.$pages.eq( i ),
					pageData	= {
						theClass				: 'page',
						theContentFront			: $page.html(),
						theContentBack			: ( i !== this.pagesCount ) ? this.$pages.eq( i + 1 ).html() : '',
						theStyle				: 'z-index: ' + ( this.pagesCount - i ) + ';left: ' + ( this.windowProp.width / 2 ) + 'px;',
						theContentStyleFront	: 'width:' + this.windowProp.width + 'px;',
						theContentStyleBack		: 'width:' + this.windowProp.width + 'px;'
					};
				
				if( i === 0 ) {
				
					pageData.theClass += ' cover';
				
				}
				else {
					
					pageData.theContentStyleFront += 'left:-' + ( this.windowProp.width / 2 ) + 'px';
					
					if( i === this.pagesCount - 2 ) {
					
						pageData.theClass += ' cover-back';
					
					}
				
				}
				
				$( '#pageTmpl' ).tmpl( pageData ).appendTo( this.$el );
			
			}
			
			this.$pages.remove();
			this.$flipPages		= this.$el.children( 'div.page' );
			this.flipPagesCount	= this.$flipPages.length;
			
			this._adjustLayout( ( this.state === undefined ) ? this.currentPage : this.state );
			
		},
		_setLayoutSize		: function() {
		
			this.$el.css( {
				width	: this.windowProp.width,
				height	: this.windowProp.height
			} );
		
		},
		_initTouchSwipe		: function() {
			
			var _self = this;
			
			this.$el.swipe( {
				threshold			: 0,
				swipeStatus			: function( event, phase, start, end, direction, distance ) {
					
					var startX		= start.x,
						endX		= end.x,
						sym, angle,
						oob			= false,
						noflip		= false;
					
					// check the "page direction" to flip:
					// if the page flips from the right to the left (right side page)
					// or from the left to the right (left side page).
					// check only if not animating
					if( !_self._isAnimating() ) {
					
						( startX < _self.windowProp.width / 2 ) ? _self.flipSide = 'l2r' : _self.flipSide = 'r2l';
					
					}
					
					if( direction === 'up' || direction === 'down' ) {
						
						if( _self.angle === undefined || _self.angle === 0 ) {
						
							_self._removeOverlays();
							return false;
						
						}
						else {
							
							( _self.angle < 90 ) ? direction = 'right' : direction = 'left';
							
						}
						
					};
					
					_self.flipDirection = direction;
					
					// on the first & last page neighbors we don't flip
					if( _self.currentPage === 0 && _self.flipSide === 'l2r' || _self.currentPage === _self.flipPagesCount && _self.flipSide === 'r2l' ) {
						
						return false;
					
					}
					
					// save ending point (symetric point):
					// if we touch / start dragging on, say [x=10], then
					// we need to drag until [window's width - 10] in order to flip the page 100%.
					// if the symetric point is too close we are giving some margin:
					// if we would start dragging right next to [window's width / 2] then
					// the symmetric point would be very close to the starting point. A very short swipe
					// would be enough to flip the page..
					sym	= _self.windowProp.width - startX;
					
					var symMargin = 0.9 * ( _self.windowProp.width / 2 );
					if( Math.abs( startX - sym ) < symMargin ) {
					
						( _self.flipSide === 'r2l' ) ? sym -= symMargin / 2 : sym += symMargin / 2;
					
					}
					
					// some special cases:
					// Page is on the right side, 
					// and we drag/swipe to the same direction
					// ending on a point > than the starting point
					// -----------------------
					// |          |          |
					// |          |          |
					// |   sym    |     s    |
					// |          |      e   |
					// |          |          |
					// -----------------------
					if( endX > startX && _self.flipSide === 'r2l' ) {
					
						angle		= 0;
						oob 		= true;
						noflip		= true;
					
					}
					// Page is on the right side, 
					// and we drag/swipe to the opposite direction
					// ending on a point < than the symmetric point
					// -----------------------
					// |          |          |
					// |          |          |
					// |   sym    |     s    |
					// |  e       |          |
					// |          |          |
					// -----------------------
					else if( endX < sym && _self.flipSide === 'r2l' ) {
					
						angle		= 180;
						oob 		= true;
					
					}
					// Page is on the left side, 
					// and we drag/swipe to the opposite direction
					// ending on a point > than the symmetric point
					// -----------------------
					// |          |          |
					// |          |          |
					// |    s     |   sym    |
					// |          |      e   |
					// |          |          |
					// -----------------------
					else if( endX > sym && _self.flipSide === 'l2r' ) {
					
						angle		= 0;
						oob 		= true;
					
					}
					// Page is on the left side, 
					// and we drag/swipe to the same direction
					// ending on a point < than the starting point
					// -----------------------
					// |          |          |
					// |          |          |
					// |    s     |   sym    |
					// |   e      |          |
					// |          |          |
					// -----------------------
					else if( endX < startX && _self.flipSide === 'l2r' ) {
					
						angle		= 180;
						oob 		= true;
						noflip		= true;
					
					}
					// we drag/swipe to a point between 
					// the starting point and symetric point
					// -----------------------
					// |          |          |
					// |    s     |   sym    |
					// |   sym    |    s     |
					// |         e|          |
					// |          |          |
					// -----------------------
					else {
						
						var s, e, val;
						
						( _self.flipSide === 'r2l' ) ?
							( s = startX, e = sym, val = startX - distance ) : 
							( s = sym, e = startX , val = startX + distance );
						
						angle = _self._calcAngle( val, s, e );
						
						if( ( direction === 'left' && _self.flipSide === 'l2r' ) || ( direction === 'right' && _self.flipSide === 'r2l' ) ) {
							
							noflip	= true;
						
						}
						
					}
					
					switch( phase ) {
					
						case 'start' :
							
							if( _self._isAnimating() ) {
								
								// the user can still grab a page while one is flipping (in this case not being able to move)
								// and once the page is flipped the move/touchmove events are triggered..
								_self.start = true;
								return false;
							
							}
							else {
								
								_self.start = false;
							
							}
							
							// check which page is clicked/touched
							_self._setFlippingPage();
							
							// check which page comes before & after the one we are clicking
							_self.$beforePage 	= _self.$flippingPage.prev();
							_self.$afterPage 	= _self.$flippingPage.next();
							
							break;
							
						case 'move' :
							
							if( distance > 0 ) {
							
								if( _self._isAnimating() || _self.start ) {
										
									return false;
								
								}
								
								// adds overlays: shows shadows while flipping
								if( !_self.hasOverlays ) {
									
									_self._addOverlays();
									
								}
								
								// save last angle
								_self.angle = angle;
								// we will update the rotation value of the page while we move it
								_self._turnPage( angle , true );
							
							}
							break;
							
						case 'end' :
							
							if( distance > 0 ) {
								
								if( _self._isAnimating() || _self.start ) return false;
								
								_self.isAnimating = true;
								
								// keep track if the page was actually flipped or not
								// the data flip will be used later on the transitionend event
								( noflip ) ? _self.$flippingPage.data( 'flip', false ) : _self.$flippingPage.data( 'flip', true );
								
								// if out of bounds we will "manually" flip the page,
								// meaning there will be no transition set
								if( oob ) {
									
									if( !noflip ) {
										
										// the page gets flipped (user dragged from the starting point until the symmetric point)
										// update current page
										_self._updatePage();
									
									}
									
									_self._onEndFlip( _self.$flippingPage );
								
								}
								else {
									
									// save last angle
									_self.angle = angle;
									// calculate the speed to flip the page:
									// the speed will depend on the current angle.
									_self._calculateSpeed();
							
									switch( direction ) {
										
										case 'left' :
											
											_self._turnPage( 180 );
											
											if( _self.flipSide === 'r2l' ) {
												
												_self._updatePage();
											
											}
											
											break;
										
										case 'right' :
											
											_self._turnPage( 0 );
											
											if( _self.flipSide === 'l2r' ) {
												
												_self._updatePage();
											
											}
											
											break;
										
									};
								
								}
								
							}
							
							break;

					};
					
				}
				
			} );
		
		},
		_setFlippingPage	: function() {
			
			var _self = this;
			
			( this.flipSide === 'l2r' ) ?
				this.$flippingPage 	= this.$flipPages.eq( this.currentPage - 1 ) :
				this.$flippingPage	= this.$flipPages.eq( this.currentPage );
			
			this.$flippingPage.on( 'webkitTransitionEnd.flips transitionend.flips OTransitionEnd.flips', function( event ) {
				
				if( $( event.target ).hasClass( 'page' ) ) {
				
					_self._onEndFlip( $(this) );
				
				}
				
			});
		
		},
		_updatePage			: function() {
			
			if( this.flipSide === 'r2l' ) {
			
				++this.currentPage;
				
			}
			else if( this.flipSide === 'l2r' ) {
			
				--this.currentPage;
				
			}
			
		},
		_isAnimating		: function() {
		
			if( this.isAnimating ) {
			
				return true;
			
			}
			
			return false;
		
		},
		_loadEvents			: function() {
			
			var _self = this;
			
			$( window ).on( 'resize.flips', function( event ) {
			
				_self._getWinSize();
				_self._setLayoutSize();
				
				var $contentFront	= _self.$flipPages.children( 'div.front' ).find( 'div.content' ),
					$contentBack	= _self.$flipPages.children( 'div.back' ).find( 'div.content' )
				
				_self.$flipPages.css( 'left', _self.windowProp.width / 2 );
				
				$contentFront.filter( function( i ) {
					return i > 0;
				}).css( {
					width	: _self.windowProp.width,
					left	: -_self.windowProp.width / 2
				} );
				$contentFront.eq( 0 ).css( 'width', _self.windowProp.width );
				
				$contentBack.css( 'width', _self.windowProp.width );
			
			} );
			
			$( window ).on( 'statechange.flips', function( event ) {
				
				_self._getState();
				_self._goto();
				if( !_self.isAnimating ) {
				
					_self._adjustLayout( _self.currentPage );
					
				}
				
			} );
			
			this.$flipPages.find( '.box' ).on( 'click.flips', function( event ) {
				
				var $box 			= $(this),
					$boxClose		= $( '<span class="box-close">close</span>' ),
					transitionProp	= {
						speed			: 450,
						timingfunction	: 'linear'
					},
					$overlay		= $( '<div class="overlay">close</div>' ).css( {
						'z-index'				: 9998,
						'-webkit-transition' 	: 'opacity ' + transitionProp.speed + 'ms ' + transitionProp.timingfunction,
						'-moz-transition' 		: 'opacity ' + transitionProp.speed + 'ms ' + transitionProp.timingfunction
					} ).prependTo( $( 'body' ) ),
					prop 			= {
						width	: $box.outerWidth(true),
						height	: $box.outerHeight(true),
						left	: $box.offset().left,
						top		: $box.offset().top
					},
					$placeholder 	= $box.clone().css( {
						'position' 			: 'absolute',
						'width'				: prop.width,
						'height'			: prop.height,
						'left'				: prop.left,
						'top'				: prop.top,
						'zIndex'			: 9999,
						'overflow-y'		: 'auto',
						'-webkit-transition': 'all ' + transitionProp.speed + 'ms ' + transitionProp.timingfunction,
						'-moz-transition': 'all ' + transitionProp.speed + 'ms ' + transitionProp.timingfunction
					} )
					.insertAfter( $overlay )
					.end()
					.append( $boxClose.on( 'click.flips', function( event ) {
						
						$overlay.css( 'opacity', 0 );
						
						$placeholder.children().hide().end().removeClass( 'box-expanded' ).css( {
							width			: _self.windowProp.width,
							height			: _self.windowProp.height,
							'overflow-y' 	: 'hidden'
						} );
						
						setTimeout( function() {
							$placeholder.css( {
								left    : prop.left,
								top		: prop.top,
								width	: prop.width,
								height	: prop.height,
								'-webkit-transition' 	: 'all ' + transitionProp.speed + 'ms ' + transitionProp.timingfunction,
								'-moz-transition' 	: 'all ' + transitionProp.speed + 'ms ' + transitionProp.timingfunction
							});
						}, 0 );
						
					}) )
					.children()
					.hide()
					.end()
					.on( 'webkitTransitionEnd.flips transitionend.flips OTransitionEnd.flips', function( event ) {
						
						if( $( event.target ).hasClass( 'box-expanded' ) ) { // expanding
							
							$(this).css( {
								width	: '100%',
								height	: '100%',
								'-webkit-transition' : 'none',
								'-moz-transition' : 'none'
							} ).children().fadeIn();
						
						}
						else { // collapsing
							
							$overlay.remove();
							$(this).remove();
						
						}

					});
				
				setTimeout( function() {
					
					$overlay.css( {
						opacity	: 1
					} );
					
					$placeholder.addClass( 'box-expanded' ).css( {
						left    : 0,
						top		: 0,
						width	: _self.windowProp.width,
						height	: _self.windowProp.height
					});
					
				}, 0 );
				
			} );
			
		},
		_onEndFlip			: function( $page ) {
			
			// if the page flips from left to right we will need to change the z-index of the flipped page
			if( ( this.flipSide === 'l2r' && $page.data( 'flip' ) ) || 
				( this.flipSide === 'r2l' && !$page.data( 'flip' ) )  ) {

				$page.css( 'z-index', this.pagesCount - 2 - $page.index() );
			
			}
			
			this.$flippingPage.css( {
				'-webkit-transition' 	: 'none',
				'-moz-transition' 		: 'none'
			} );
			
			// remove overlays
			this._removeOverlays();
			this._saveState();
			this.isAnimating = false;
			
			// hack (todo: issues with safari / z-indexes)
			if( this.flipSide === 'r2l' || ( this.flipSide === 'l2r' && !$page.data( 'flip' ) ) ) {
			
				this.$flippingPage.find('.back').css( '-webkit-transform', 'rotateY(-180deg)' );
			
			}
			
		},
		// given the touch/drag start point (s), the end point (e) and a value in between (x)
		// calculate the respective angle ( 0deg - 180deg )
		_calcAngle			: function( x, s, e ) {
			
			return ( -180 / ( s - e ) ) * x + ( ( s * 180 ) / ( s - e ) );
		
		},
		// given the current angle and the default speed, calculate the respective speed to accomplish the flip
		_calculateSpeed		: function() {
			
			( this.flipDirection === 'right' ) ? 
				this.flipSpeed = ( this.options.flipspeed / 180 ) * this.angle :
				this.flipSpeed = - ( this.options.flipspeed / 180 ) * this.angle + this.options.flipspeed;
		
		},
		_turnPage			: function( angle, update ) {
			
			// hack / todo: before page that was set to -181deg should have -180deg
			this.$beforePage.css({
				'-webkit-transform'	: 'rotateY( -180deg )',
				'-moz-transform'	: 'rotateY( -180deg )'
			});
			
			// if not moving manually set a transition to flip the page
			if( !update ) {
				
				this.$flippingPage.css( {
					'-webkit-transition' : '-webkit-transform ' + this.flipSpeed + 'ms ' + this.options.fliptimingfunction,
					'-moz-transition' : '-moz-transform ' + this.flipSpeed + 'ms ' + this.options.fliptimingfunction
				} );
				
			}
			
			// if page is a right side page, we need to set its z-index higher as soon the page starts to flip.
			// this will make the page be on "top" of the left ones.
			// note: if the flipping page is on the left side then we set the z-index after the flip is over.
			// this is done on the _onEndFlip function.
			var idx	= ( this.flipSide === 'r2l' ) ? this.currentPage : this.currentPage - 1;
			if( this.flipSide === 'r2l' ) {
				
				this.$flippingPage.css( 'z-index', this.flipPagesCount - 1 + idx );
			
			}
			
			// hack (todo: issues with safari / z-indexes)
			this.$flippingPage.find('.back').css( '-webkit-transform', 'rotateY(180deg)' );
			
			// update the angle
			this.$flippingPage.css( {
				'-webkit-transform'		: 'rotateY(-' + angle + 'deg)',
				'-moz-transform'		: 'rotateY(-' + angle + 'deg)'
			} );
			
			// show overlays
			this._overlay( angle, update );
			
		},
		_addOverlays		: function() {
			
			var _self = this;
			
			// remove current overlays
			this._removeOverlays();
			
			this.hasOverlays	= true;
			
			// overlays for the flipping page. One in the front, one in the back.
			
			this.$frontoverlay	= $( '<div class="flipoverlay"></div>' ).appendTo( this.$flippingPage.find( 'div.front > .outer' ) );
			this.$backoverlay	= $( '<div class="flipoverlay"></div>' ).appendTo( this.$flippingPage.find( 'div.back > .outer' ) )
			
			// overlay for the page "under" the flipping page.
			if( this.$afterPage ) {
				
				this.$afterOverlay	= $( '<div class="overlay"></div>' ).appendTo( this.$afterPage.find( 'div.front > .outer' ) );
			
			}
			
			// overlay for the page "before" the flipping page
			if( this.$beforePage ) {
				
				this.$beforeOverlay	= $( '<div class="overlay"></div>' ).appendTo( this.$beforePage.find( 'div.back > .outer' ) );
			
			}
		
		},
		_removeOverlays		: function() {
			
			// removes the 4 overlays
			if( this.$frontoverlay )
				this.$frontoverlay.remove();
			if( this.$backoverlay )
				this.$backoverlay.remove();
			if( this.$afterOverlay )
				this.$afterOverlay.remove();
			if( this.$beforeOverlay )
				this.$beforeOverlay.remove();
				
			this.hasOverlays	= false;
				
		},
		_overlay			: function( angle, update ) {
			
			// changes the opacity of each of the overlays.
			if( update ) {
				
				// if update is true, meaning we are manually flipping the page,
				// we need to calculate the opacity that corresponds to the current angle
				var afterOverlayOpacity 	= - ( 1 / 90 ) * angle + 1,
					beforeOverlayOpacity 	= ( 1 / 90 ) * angle - 1;
				
				if( this.$afterOverlay ) {
				
					this.$afterOverlay.css( 'opacity', afterOverlayOpacity );
					
				}
				if( this.$beforeOverlay ) {
				
					this.$beforeOverlay.css( 'opacity', beforeOverlayOpacity );
					
				}
				
				// the flipping page will have a fixed value.
				// todo: add a gradient instead.
				var flipOpacity 	= 0.1;
				this.$frontoverlay.css( 'opacity', flipOpacity );
				this.$backoverlay.css( 'opacity', flipOpacity );
				
			}
			else {
				
				var _self = this;
				
				// if we release the mouse / touchend then we will set a transition for the overlays.
				// we will need to take in consideration the current angle, the speed (given the angle)
				// and the delays for each overlay (the opacity of the overlay will only change
				// when the flipping page is on the same side).
				var afterspeed	= this.flipSpeed,
					beforespeed	= this.flipSpeed,
					margin		= 60; // hack (todo: issues with safari / z-indexes)
				
				if( this.$afterOverlay ) {
				
					var afterdelay = 0;
					
					if( this.flipDirection === 'right' ) {
						
						if( this.angle > 90 ) {
							
							afterdelay 	= Math.abs( this.flipSpeed - this.options.flipspeed / 2 - margin );
							afterspeed	= this.options.flipspeed / 2 - margin ;
						
						}
						else {
							
							afterspeed -= margin;
						
						}
						
					}
					else {
						
						afterspeed	= Math.abs( this.flipSpeed - this.options.flipspeed / 2 );
					
					}
					
					if( afterspeed <= 0 ) afterspeed = 1;
					
					this.$afterOverlay.css( {
						'-webkit-transition' 	: 'opacity ' + afterspeed + 'ms ' + this.options.fliptimingfunction + ' ' + afterdelay + 'ms',
						'-moz-transition' 		: 'opacity ' + afterspeed + 'ms ' + this.options.fliptimingfunction + ' ' + afterdelay + 'ms',
						'opacity'				: ( this.flipDirection === 'left' ) ? 0 : 1
					} ).on( 'webkitTransitionEnd.flips transitionend.flips OTransitionEnd.flips', function( event ) {
						if( _self.$beforeOverlay ) _self.$beforeOverlay.off( 'webkitTransitionEnd.flips transitionend.flips OTransitionEnd.flips');
						setTimeout( function() {
							_self._adjustLayout(_self.currentPage);
						}, _self.options.flipspeed / 2 - margin );
					} );
					
				}
				
				if( this.$beforeOverlay ) {
				
					var beforedelay = 0;
					
					if( this.flipDirection === 'left' )  {
						
						if( this.angle < 90 ) {
						
							beforedelay = Math.abs( this.flipSpeed - this.options.flipspeed / 2 - margin ) ;
							beforespeed = this.options.flipspeed / 2 - margin;
						
						}
						else {
							
							beforespeed -= margin;
						
						}
						
					}
					else {
						
						beforespeed = Math.abs( this.flipSpeed - this.options.flipspeed / 2 );
						
					}
					
					if( beforespeed <= 0 ) beforespeed = 1;
					
					this.$beforeOverlay.css( {
						'-webkit-transition'	: 'opacity ' + beforespeed + 'ms ' + this.options.fliptimingfunction + ' ' + beforedelay + 'ms',
						'-moz-transition'		: 'opacity ' + beforespeed + 'ms ' + this.options.fliptimingfunction + ' ' + beforedelay + 'ms',
						'opacity'				: ( this.flipDirection === 'left' ) ? 1 : 0
					} ).on( 'webkitTransitionEnd.flips transitionend.flips OTransitionEnd.flips', function( event ) {
						if( _self.$afterOverlay ) _self.$afterOverlay.off( 'webkitTransitionEnd.flips transitionend.flips OTransitionEnd.flips');
						_self._adjustLayout(_self.currentPage);
					} );
					
				}
				
			}
				
		}
	};
	
	var logError 		= function( message ) {
		if ( this.console ) {
			console.error( message );
		}
	};
	
	$.fn.flips			= function( options ) {
		
		if ( typeof options === 'string' ) {
			
			var args = Array.prototype.slice.call( arguments, 1 );
			
			this.each(function() {
			
				var instance = $.data( this, 'flips' );
				
				if ( !instance ) {
					logError( "cannot call methods on flips prior to initialization; " +
					"attempted to call method '" + options + "'" );
					return;
				}
				
				if ( !$.isFunction( instance[options] ) || options.charAt(0) === "_" ) {
					logError( "no such method '" + options + "' for flips instance" );
					return;
				}
				
				instance[ options ].apply( instance, args );
			
			});
		
		} 
		else {
		
			this.each(function() {
			
				var instance = $.data( this, 'flips' );
				if ( !instance ) {
					$.data( this, 'flips', new $.Flips( options, this ) );
				}
			});
		
		}
		
		return this;
		
	};
	
})( window );

-----------------------------------CORE SKILLS-----------------------------------------
JAVASCRIPT
expert = [
  'Understands the application of and demonstrates expert knowledge of HTML, CSS, and JavaScript',
  'Are expert at working with JavaScript, HTML, and CSS',
  'JavaScript wizard',
  'Strong experience with HTML5, CSS3 and JavaScript',
  'expert knowledge of JavaScript',
  'jQuery-UI / jQuery-UI widgets /jQuery-mobile',
  'Mastery of JS Frameworks like  and JQuery with ability to use as a tool, not a crutch.',
  'You live and breath AJAX, semantic layouts, browser testing, MVC, Firebug/Chrome Dev Tools, and all that is modern front-end web development.',
  'Experience developing code for high-traffic web sites',
  'You love the web and building web apps.',
  'expert level developer',
  'beautiful front-end code',
  'Know HTML and CSS like the back of your hand.'
]

solid = [
  'Extensive experience with JavaScript, including JQuery and AJAX',
  'Develop using the latest client-side web technologies, specifically HTML5, CSS and JavaScript (jQuery)',
  'we are looking for someone who can take their finished designs and make them live and breathe using standards-driven, semantic HTML, CSS and Javascript.',
  'rock-solid JavaScript/HTML/CSS/image production skills',
  'you’re responsible for developing and refining the client-facing HTML, Javascript and CSS portions of our platform',
  'Architect and implement complex user interactions through JavaScript, CSS and HTML',
  'You love Javascript, HTML, CSS and all their quirks',
  'Extensive experience using Ajax, jQuery',
  'Extensive experience with JavaScript, including JQuery and AJAX',  
  'You have an online portfolio with working sites or examples.',
  'links to your work',
  'Code examples',
  'Create beautiful and scalable code that is well structured and documented',
  'beautiful front-end code',
  'experienced developer',
  'You have real-world experience shipping code',
  'experienced Front-end Developer',
  'Architect CSS that is scalable, reusable',
  'Extensive experience crafting HTML and CSS, and familiarity with pre-processors such as LESS and Sass'
]

working = [
  'Working knowledge of Javascript',
  'Experience with front-end web development',
  'Have created customer-facing web applications in the past.',  
  'Experience developing consumer-facing websites in a professional production environment a plus'
]


VISUAL_DESIGN
expert = 
[
  'strong visual design',
  'You can take a layered PSD and build pixel-perfect pages',
  'major emphasis and value both on style and UX with magical functionality',
  'Strong portfolio of visual design examples',
  'prototyping and creating responsive and elegant UIs', 
  'great user interfaces',

]

solid = 
[
  'Experience with graphic design',
  'Have a Good eye for design',
  'good web design chops',
  'eye for design',
  'UI design and implementation',
  'Skills and experience prototyping, designing, testing, implementing, and evaluating user experience for web based applications',
  'ability to write and debug UI components'

]

working_knowledge = 
[
  'graphic design',
  'graphic design/illustration',
  'You understand and can contribute to product design. You’re not “technically” a designer, but you appreciate and understand good UI design, UX, and typography.'
]

----------------------------------- ADDL -----------------------------------------

education = [
  'In the process of receiving a BS or MS in Computer Science'
  'BA/BS in human/computer interaction'
  'A BS or MS degree in Comupter Science or a related technical field is preferred.'
  'A Bachelors, Masters or PhD in Computer Science'
]


browser_skills = [
  'cross-platform and cross-browser environment',
  'cross-browser debugging skills (IE7+ and “modern browsers”)',
  'across browsers',
  'browser quirks',
  'pushing browsers to their limits',
  'multiple browsers'
]

framework = [
  'Prototype'
  'Angular'
  'Ember'
  'Backbone'
  'Meteor'
  'HAML'
  'Grunt'
  'coffeescript'
  'clojurescript'
  'bootstrap'
  'handlebar'
  'underscore'
]


back_end = 
[
  'PHP'
  'Ruby' 
  'Python'
  'perl'
  'RoR'
  'PHP'
  'Node'
  'Java'
  'Drupal'
  'Ruby on Rails'
]

mobile = [
  'Experience with mobile development a plus'
  'Working knowledge of HTML5, CSS3 and web/mobile standards'
  'Experience developing iOS and/or Android applications'  
]

database = 
[
  'Prior experience with MongoDB and a genuine interest in databases a HUGE plus!'
]

adobe = 
[
  'Possesses excellent working knowledge of the Adobe Creative Suite, specifically Photoshop'
  'Expert knowledge of the entire adobe suite.'
  'Experience with Illustration'
  'Photoshop / Adobe Creative Suite'   
]

git = [
  'Familiar with source control principles and comfortable with Git'
  'Git/Github' 
  'Comfort with git, linux, and virtualized cross-os/browser development'
  'Experience working with version control systems, specifically git'
]

other = [
  'CMS'
  'API'
  'reponsive design'
  'a/b testing'  
]


expert = [
  'Understands the application of and demonstrates expert knowledge of',
  'Are expert at working with',
  'wizard',
  'Strong experience with',
  'expert knowledge of'
]

solid = [
  'Extensive experience with',
  'Develop using the latest',
  'rock-solid skills',
  'responsible for developing and refining',
  'Architect and implement complexL',
  'You love'
]


'Understands the application of and demonstrates expert knowledge of HTML, CSS, and JavaScript',
'Are expert at working with JavaScript, HTML, and CSS',
'JavaScript wizard',
'Strong experience with HTML5, CSS3 and JavaScript',
'expert knowledge of JavaScript',

'Extensive experience with JavaScript, including JQuery and AJAX'
'Develop using the latest client-side web technologies, specifically HTML5, CSS and JavaScript (jQuery)',
'we are looking for someone who can take their finished designs and make them live and breathe using standards-driven, semantic HTML, CSS and Javascript.',
'rock-solid JavaScript/HTML/CSS/image production skills',
'you’re responsible for developing and refining the client-facing HTML, Javascript and CSS portions of our platform',
'Architect and implement complex user interactions through JavaScript, CSS and HTML',
'You love Javascript, HTML, CSS and all their quirks'

['Working knowledge of Javascript']


def self.LEVELS
  [
    'analyst',
    'assistant',
    'associate',
    'chief',
    'director',
    'head',
    'intern',
    'lead',
    'national',
    'principal',
    'senior',
    'specialist',
    'vice president',
    'manager'
  ]
end

def self.ENGINEERING_TITLES
  [
    'Data Operations Associate',      
    'Automation Engineer',
    'Director of Engineering',
  ]
end


def self.dept_hash
  {
    "account management" => [
      "account manager",
      'account executive',
      'account lead'
    ],
  
    "administrative" => [
      "office manager",
      "executive assistant",
      "office coordinator",
      "personal assistant",
      "receptionist",
      "administrative",
      'mail'
    ],
    
    "business analytics" => [
      'business analyst'
    ],
    
    "business development" => [
      'business development'
    ],
    
    "community" => [
      "community manager"
    ],
    
    "creative" => [
      "host",
      "producer"
    ],
    
    "customer service" => [
      'onboarding associate',
      'client support',
      'member experience',
      'member development'
    ],
    
    "content" => [
      "writer",
      "translator"
    ],
    
    "design" => [
      "ui",
      "ux",
      "graphic",
      "visual",
      'designer',
      'produce designer'
    ],
    
    "engineering" => [
      'technology lead',
      'software engineer',
      'engineer',
      'developer',
      'tech',
      'it'
    ],

    "events" => [
      'event',
      'events'
    ],
    
    "finance" => [
      "accounting",
      "accountant",
      "payroll"
    ],
    
    "growth" => [
      "user acquisition",
      "growth hacker"
    ],
    
    "human resources" => [
      "recruiter",
      "recruit",
      ' hr ',
      "human resources",
      'compensation',
      'hris',
      'hr '
    ],
    
    "legal" => [
      "counsel"
    ],
    
    "marketing" => [
      "marketing strategist",
      "digital marketing",
      "marketing analyst",
      "seo",
      "online marketing",
      "marketing specialist",
      "marketing manager",
      'head of marketing'
    ],

    "operations" => [
      'strategic operations',
      "operations associate",
      "sourcer",
      "operations specialist",
      'resource sourcing'
    ],
    
    "product" => [
      "product manager",
      "product analyst",
      "product management",
      'director of product'
    ],
    
    "project management" => [
      "project"
    ],
          
    "public relations" => [
      'public relations',
      'pr ',
      ' pr ',
      ' pr'
    ],
  
    "sales" => [
      'sales executive',
      'sales manager',
      'sales origination associate',
      'field associate',
      'director of national sales',
      'sales representative',
      'sales associate',
      'sales account',
      'sales executive',
      'sales lead',
      'enterprise sales'
    ],
    
    "strategy" => [
      "strategy associate"
    ] 
  }
end

def self.RAW_TITLES 
  [
    'Assistant Office Manager',
    'Executive Assistant',
    'Office Coordinator',
    'Personal Assistant',
    'Business Development Director',
    'Front End Developer',
    'Lead Security Engineer',
    'Manual Quality Assurance Engineer',
    'Mobile Software Engineer',
    'Mobile Tech Lead',
    'Senior Dev Ops Engineer',
    'Senior Software Engineer',
    'Software Engineer',
    'Accounting Manager',
    'Finance & Strategy Associate',
    'Payroll Associate',
    'Senior Accountant',
    'Account Manager',
    'Inside Sales Executive',
    'Inside Sales Manager',
    'Onboarding Associate',
    'Practice Success Associate',
    'Sales Origination Associate',
    'IT Intern',
    'PR Intern',
    'Senior Network Engineer',
    'Technical Support Lead',
    'Associate Counsel',
    'Digital Marketing Strategist',
    'Director of Digital Marketing',
    'Doctor Marketing Specialist',
    'Writer / Translator',
    'Writer / Translator',
    'Writer / Translator',
    'Writer / Translator',
    'Writer / Translator',
    'Writer / Translator',
    'Writer / Translator',
    'Marketing Analyst',
    'Marketing Strategy Associate',
    'Public Relations Manager',
    'SEO Analyst',
    'Director of Strategic Operations',
    'Operations Associate',
    'Part Time Patient Operations Associate',
    'Part Time Patient Operations Associate - Spanish',
    'Technical Operations Associate',
    'Director of Product Management',
    'Product Analyst',
    'Product Manager',
    'Recruiting Coordinator',
    'Sales Recruiter',
    'Sourcer',
    'Tech Recruiter',
    'Sales Operations Analyst',
    'Sales Operations and Strategy Manager',
    'Sales Operations Field Associate',
    'Business Analyst Intern',
    'Strategic Account Manager',
    'Strategic Project Manager',
    'Strategic Sales Director',
    'Senior Software Engineer',
    'Accountant',
    'Host',
    'Producer',
    'Chief Human Resources Officer',
    'Compensation & HRIS Analyst',
    'Data Engineer',
    'Director of National Sales',
    'Director, YBN Product Performance',
    'IT Engineer- Network, Telecom, Systems',
    'Manager of Online Marketing Operations and Analysis',
    'Manager, Partner Marketing',
    'Marketing Operations Analyst',
    'National Account Manager',
    'Online Channel Marketing Manager',
    'Operations Associate Manager for Yodle for Brand Networks',
    'Operations Specialist',
    'Public Relations Manager',
    'Receptionist and Administrative Assistant',
    'Sales Representative',
    'Senior Software Engineer',
    'Senior Systems and DevOps Engineer',
    'Senior UI Engineer',
    'Software Engineer',
    'Systems and DevOps Engineer',
    'Technical Support Specialist',
    'Yipit Data Engineer',
    'Data Product Analyst',
    'Web Developer',
    'DevOps Engineer',
    'Frontend Engineer',
    'Implementation Engineer',
    'Senior Software Engineer',
    'Software Engineer',
    'Software Engineering Manager',
    'Account Director',
    'Account Manager',
    'Senior Sales Engineer',
    'Vice President, Enterprise Sales',
    'Client Support Specialist',
    'Enterprise Operations Specialist',
    'Software Engineer, Intern - Summer 2014',
    'SMB Sales Associate, University Graduate',
    'Enterprise Sales, Intern - Summer 2014',
    'Yext Sales Manager',
    'Yext Sales Associate',
    'Senior Product Manager',
    'Senior Account Executive',
    'Partner Developer',
    'Front-End Developer',
    'Web App Developer',
    'Developer Intern',
    'Web Engineer',
    'Head of UI/UX Design',
    'Marketing Intern',
    'Analyst',
    'Senior Analyst',
    'Director, TV Analytics',
    'Account Manager - General Submission',
    'Associate - General Submission',
    'Analyst, Audience Campaign Management - General Submission',
    'Internship (unpaid)',
    'Serious Software Engineer',
    'Enterprise Sales Executive',
    'Serious Backend Software Engineer',
    'Test Engineer',
    'Support and User Acquisition',
    'Marketing Intern',
    'Client Executive/Account Manager',
    'Inside Sales Executive',
    'Account Executive - House Accounts',
    'Professional Services Manager',
    'Resource Sourcing Manager',
    'Senior Editor',
    'Advertising Sales Account Manager',
    'Operations Assistant',
    'Associate Community Manager',
    'Construction Project Manager',
    'Director of Space Development',
    'Event Sales Coordinator',
    'HR Manager',
    'iOS Developer',
    'Mail Service Associate',
    'Member Experience Manager',
    'New Member Development Associate',
    'Ruby Developer',
    'Senior Community Manager / City Lead NYC',
    'UX/UI Designer',
    'Videographer & Editor',
    'WordPress Developer',
    'Editorial Intern',
    'Events Interns',
    'Technical Intern',
    'Freelance Writers',
    'Sales',
    'Commercial Counsel',
    'Financial Analyst',
    'Facilities Manager',
    'Head of Product',
    'Customer Experience Associate',
    'Spring PR Intern',
    'Head of Global Sourcing and Supply Chain',
    'Facilities Manager',
    'Optician',
    'Advisor - Part Time',
    'Optometrist',
    'Director, Tech Ops',
    'Principal Software Engineer, e-Commerce',
    'Software Engineer',
    'Infrastructure Engineer',
    'Software Engineer, Data Science',
    'Retail Support Engineer',
    'Project Manager, Systems Development',
    'Principal Software Engineer, Core Services',
    'Senior Software Engineer',
    'Automation Engineer',
    'Technology Intern',
    'Junior Software Engineer',
    'Back Office Engineer',
    'Data Scientist',
    'Front-End Developer',
    'Spring 2014 Interns',
    'Mobile Application Developer',
    'Senior Software Engineer',
    'Marketing Director',
    'Front End Engineer',
    'Back End Engineer',
    'Dev Ops Engineer',
    'Sales Executive',
    'UI Designer',
    'Front-End Developer',
    'Business Development Intern',
    'Social Media Specialist Intern',
    'Director, Business Development - Creator Platform',
    'Head of Content Strategy & Business Development',
    'Moderation Manager',
    'Hadoop Engineer',
    'Designer, Mobile Web',
    'Talent Network',
    'Corporate Counsel',
    'Manager, Marketing Analytics',
    'Director, Product Management - Audience',
    'Senior iOS Engineer',
    'Senior Mobile Project Manager',
    'Front-End Engineer (PHP / JavaScript)',
    'Search Engineer',
    'Associate Sales Representative',
    'Director, User Data Products',
    'LAMP Developer',
    'Sr. IOS Developer',
    'Sr. Android Developer',
    'Sr. Java Software Engineer',
    'Sr. Project Manager',
    'Digital Art Director',
    'Technical Recruiter',
    'Business Operations',
    'Product Designer - Venmo',
    'Android Engineer',
    'Engineering Internship - NYC',
    'Growth Engineer',
    'Internal Tools Engineering Lead',
    'iOS Engineer - New York',
    'Senior Data Engineer',
    'Software Engineer',
    'Systems Engineer',
    'Web Engineer',
    'Manager, Mobile API Growth',
    'Mobile Developer',
    'Mobile Developer (Intern)',
    'Business Development',
    'Business Development (Intern)',
    'Translation Coordinator ',
    'Communications Manager',
    'Communications Assistant ',
    'Production and Circulation Manager ',
    'Creative',
    'Project Budget Assistant ',
    'Sales Representative ',
    'Accounts Payable Assistant',
    'Java Developer (Front-end)',
    'Ad Ops Campaign Manager',
    'Front-End Mobile Web Developer (Front-End Engineer)',
    'Lead Mobile Android Engineer',
    'Sr. MySQL Database Engineer',
    'Intern - Rewards',
    'Manager, Integrated Marketing Solutions',
    'Sales Planner',
    'Digital Strategist, DSP/Trading Desk - Programmatic (NYC)',
    'Sales Planner',
    'Digital Media Analyst, DSP/Trading Desk - Programmatic (NYC)',
    'Account Director',
    'Account Executive',
    'Account Lead',
    'Analyst',
    'Community Manager',
    'Designer',
    'Group Director',
    'Media Manager',
    'Micro-Content Producer',
    'Senior Interface Engineer',
    'Summer Interns',
    'Project Manager',
    'Senior Business Development Executive',
    'Business Development Executive',
    'Strategic Account Manager',
    'Account Manager',
    'Sales Lead',
    'Curator',
    'Open Ended',
    'Head of Marketing',
    'Growth Hacker',
    'Front End Architect',
    'Mobile Application Architect',
    'Data Scientist',
    'Recruiter and HR Specialist ',
    'Experienced Licensed Real Estate Salesperson/Associate Broker',
    'Campus Ambassador',
    'Lead Perks Production Coordinator',
    'Customer Service Coordinator',
    'Editorial Assistant',
    'NYC Staff Writer',
    'Software Engineer, Front-End',
    'Editorial/Reporting Internship, Spring 2014',
    'Spring 2014 Internship',
    'Account Manager',
    'Marketing Manager',
    'Ad Operations Associate',
    'Perks Sales Manager',
    'Marketing Internship',
    'Business Development Team Internship',
    'Sustainability Internship',
    'Legal Internship',
    'PR and Communications',
    'Developer Operations Engineer',
    'Accounting Intern',
    'Business Development Representative',
    'Enterprise Sales Executive',
    'Sales Engineer',
    'Director of Engineering, Applications',
    'Jr. Applications Developer',
    'Sr. Applications Developer',
    'Account Manager',
    'Social Media Buyer',
    'Senior Engineer - Web',
    'Customer Support Associate',
    'Marketing Director',
    'Mobile Apps Engineer',
    'Merchandise Planning Analyst',
    'HR Director',
    'Senior Planner',
    'Purchasing Intern',
    'Drop Ship Intern',
    'Assistant Merchandise Coordinator',
    'Graphic Designer',
    'Senior Copywriter',
    'Copywriter',
    'Photography Intern',
    'Graphic Designer Intern',
    'Analyst, Data Science',
    'Public Relations Intern',
    'Customer Service Supervisor',
    'Operations Staffing Intern',
    'Software Developer Intern',
    'Executive Assistant',
    'Human Resources Manager of Recruiting',
    'Merchandising Director/Head Buyer',
    'Associate Buyer',
    'Buyer',
    'Assistant Buyer',
    'Merchandising Intern',
    'Graphic Designer - Product Development',
    'Assistant Production Manager',
    'Slotting Intern',
    'Operations Data/Process Analyst Intern',
    'Technical Account Manager / Client Solutions Engineer',
    'Account Executive/Sales Director',
    'UI Engineer',
    'Marketing Manager',
    'Web Services Engineer',
    'Webserver Engineer',
    'MBA Intern, Business Development',
    'Production Designer',
    'Android Engineer',
    'API Engineer',
    'Data Center Technician',
    'Director of Site Reliability ( SRE )',
    'Engineering Summer Intern',
    'Front-End Product Engineer',
    'iOS Engineer/Mobile Developer (iOS)',
    'MySQL Engineer',
    'PHP Application Engineer',
    'Search & Discovery: Data Scientist',
    'Search & Discovery: Software Engineer',
    'Site Reliability Engineer',
    'Trust & Safety Manager',
    'Senior Engineering Recruiter',
    'Brand Strategist, New York',
    'Software Developer',
    'QA Automation/Deployment Engineer',
    'Tools/Platform Developer',
    'Account Executive',
    'Account Manager, Publisher Development',
    'Analyst, Advertising Operations',
    'Controller',
    'Software Developer',
    'Customer Service Case Manager',
    'Senior Linux System Administrator',
    'Senior Product Manager',
    'Senior Software Engineer – Integration Architecture',
    'Senior Software Engineer',
    'Software Engineer',
    'Systems Analyst',
    'Intern',
    'User Interface Developer',
    'Java Algorithm Developer',
    'Server Side Developer',
    'Junior Product Design Engineer',
    'Tomorrow Lab Internship',
    'Client Services Specialist',
    'Frontend developer - Junior',
    'QA Engineer',
    'Sales Engineer',
    'Senior Web Software Engineer',
    'Web Software Engineer',
    'Events Coordinator',
    'Sales Marketing Associate',
    'Ad Operations Coordinator',
    'Events & Promotions Intern',
    'Director, Strategic Analytics',
    'PR Intern',
    'Communications Coordinator',
    'Design Intern',
    'Graphic Designer',
    'Editorial Internship',
    'Staff Writer',
    'Style Editor',
    'Accounts Payable Inventory Specialist',
    'Accounts Payable Specialist',
    'Recruiter',
    'Photographer',
    'Photo Stylist',
    'Editor',
    'Lifestyle Product Editor',
    'Sr. Manager, Customer Acquisition',
    'Social Media Coordinator',
    'Retention Coordinator',
    'Assistant Merchandise Planner',
    'Sr. Digital Analyst',
    'Business Analyst',
    'Studio Planning Intern',
    'Studio Prepper',
    'Product Photographer',
    'Soft Goods Stylist',
    'Studio Assistant',
    'Studio Production Assistant',
    'Shops Editor',
    'Interface Developer',
    'iOS Developer',
    'Web Applications Developer',
    'Junior Product Manager',
    'MySQL DBA',
    'Developer',
    'Director of Product',
    'Director of Engineering',
    'Account Executive',
    'Head of Marketing',
    'Graphic Designer',
    'Business Analyst, MBA Intern',
    'Product Intern',
    'Marketing Intern',
    'Paid Marketing Manager',
    'Communications & Social Media Manager',
    'Engineering',
    'Front End Web Development Mentor',
    'Python Mentor',
    'Ruby on Rails Mentor',
    'iOS Development Mentor',
    'Product Specialist',
    'M&A Reporter',
    'Bankruptcy reporter',
    'Social Media Coordinator',
    'Temporary Part-Time Customer Service Representative',
    'Senior Editorial Research Coordinator',
    'SEO Associate',
    'Director of Analytics & Consumer Insights',
    'Systems Administrator',
    'Senior Data Coordinator',
    'Email Marketing Manager',
    'Digital Journalist',
    'Senior Software Engineer',
    'Senior Architect',
    'Business Development Manager',
    'Front End Developer',
    'Software Engineer',
    'iOS Developer',
    'Interaction Designer',
    'Art Director - Product/UX',
    'Product Manager',
    'Inside Sales Manager',
    'Account Executive',
    'Account Manager',
    'Manager, PR',
    'CRM Manager',
    'Software Engineer',
    'Community Manager',
    'Freelance/Junior Web Designer',
    'Director, Children’s Video Distribution (New York, NY)',
    'Senior Software Engineer (New York, NY)',
    'Corporate Marketing Coordinator (New York, NY)',
    'MCN Team Intern',
    'Content Management Intern',
    'Interactive Marketing Internship',
    'Retail Marketing Internship',
    'Corporate Marketing Internship',
    'Client Services Internship',
    'Video Operations Internship',
    'Film Distribution Internship',
    'Licensing and Creative Services Internship',
    'Operations Internship',
    'Physical Distribution Internship',
    'Graphic Design Internship',
    'Senior Editor',
    'Executive & Operational Assistant',
    'Advertising & Sales Internship',
    'Internship',
    'Associate Project Manager',
    'Developer',
    'Jr. Developer',
    'iOS Developer',
    'Office Manager',
    'Event Technician',
    'Office Intern',
    'Software Development Intern',
    'SOCIAL MEDIA SOFTWARE DEVELOPER',
    'WEB DEVELOPER',
    'FRONT END WEB DEVELOPER',
    'Product Outreach: Community & Partnerships',
    'DevOps Engineer',
    'Lead Server Engineer',
    'Web Developer',
    'Director of Talent and Development',
    'Assistant to the TED Partnership Development Team',
    'Creative Partner Coordinator',
    'Graphic Designer',
    'Media Planner',
    'Product Development Manager',
    'TED Prize Storyteller',
    'TEDx Special Projects Intern',
    'iOS Developer – Full Time',
    'Operations Manager – Full Time',
    'Project Manager – Full Time',
    'Web Development Intern',
    'Graphics Intern',
    'Business Development - Product Partnerships',
    'Data Engineer',
    'Data Scientist',
    'Director of Financial Reporting and Analysis',
    'Director of Solutions Consulting',
    'Enterprise Project Manager',
    'Front-End Engineer',
    'Publisher Sales',
    'SaaS User Experience Designer / Visual Designer',
    'Senior Director, Statistician',
    'Senior Solutions Consulting',
    'Senior Solutions Engineer',
    'Software Engineer',
    'Supply Analyst',
    'Technical Account Manager',
    'Technical Analyst',
    'Yield Analyst',
    'Junior Rails Developer',
    'Customer Success Specialist',
    'Senior Account Executive',
    'Tech PR Manager (Full-time)',
    'Fashion PR Manager (Part-time / Freelance)',
    'Account Manager Assistant - Fashion (Internship)',
    'Account Manager Assistant - Beauty (Internship)',
    'Account Manager Assistant - Tech (Internship)',
    'Motion Graphic Designer (Internship)',
    'Video Editor Assistant (Internship)',
    'Graphic Design (Intership)',
    'Engineer',
    'Manager, Network Development',
    'Creative Technologist',
    'Field Producer',
    'Stylitics Ambassador',
    'Editor, Beauty High',
    'Developer',
    'Managing Editor',
    'Senior Web & UI Designer',
    'Social Media',
    'Analytics',
    'Technology',
    'Sales & Marketing',
    'Graphic Design',
    'Beauty Editorial',
    'Style & Lifestyle Editorial',
    'New Business Manager',
    'SENIOR INTERACTION DESIGNER',
    'FRONT END DEVELOPER',
    'INTERNSHIP: INTERACTION DESIGNER',
    'Intern',
    'Partnership Associate',
    'Ad Solutions Manager (New York)',
    'Senior Director/Director of Marketing - StreetEasy',
    'Senior Design and UX Lead - StreetEasy',
    'Head of Talent & Culture',
    'Client Development Manager',
    'Process Management Analyst',
    'Graphic Design Director',
    'Account Coordinator',
    'Sales Director',
    'Software Engineer',
    'Senior Sysop Engineer',
    'Creative Developer',
    'Dev Ops',
    'Intermediate PHP/Web Developer',
    'Full-Stack Web Developer',
    'Community Manager (bilingual English/Japanese)',
    'Global Payroll Manager',
    'Production Designer',
    'Template Developer',
    'Android Developer',
    'Network Engineer',
    'Network Engineer - Commerce',
    'Software Engineer - Data Team',
    'Software Engineer - Front End',
    'Software Engineer - Platform',
    'Software Engineer - Product',
    'Business Intelligence Analyst',
    'Business Intelligence Analyst',
    'Director, Business Development',
    'Director, Data Analytics',
    'Events Coordinator',
    'HR Operations and Technology Lead',
    'Senior Technical Recruiter',
    'Product Designer',
    'Full-Stack Web Engineer',
    'Junior Developer Internship',
    'PART-TIME SALES COORDINATOR',
    'FREELANCE SOCIAL MEDIA STRATEGIST',
    'DEVELOPERS WANTED',
    'Front End Web Developer',
    'Database Developer',
    'System Administrator',
    'Software Engineer',
    'Senior Software Engineer (PHP)',
    'QA Automation Engineer',
    'Front End Developer',
    'Python / Django Intern',
    'Publishing Operations Coordinator',
    'Publishing Operations Intern',
    'Counterpoint Intern',
    'Digital Marketing Intern',
    'QA Manager',
    '.NET App Developer',
    'Front-End Web Developer',
    'Director / Account Manager',
    'Android Development Lead',
    'iOS Engineer',
    'Infrastructure-ish Engineer',
    'Regional Sales Managers (New York, Chicago, Toronto)',
    'Ad Trafficker',
    'Yield Optimization Manager',
    'Account Manager',
    'Web Developer',
    'Systems Operations Engineer',
    'Java Engineer',
    'Public Relations Director',
    'Quality Assurance Engineer',
    'Data Scientist, R&D',
    'SENIOR APPLICATION UX & DESIGN LEAD',
    'SALES ACCOUNT EXECUTIVE',
    'ACCOUNT MANAGER',
    'Quantitative Analyst',
    'Junior Web Developer',
    'Growth Hacker Product Manager',
    'Product Manager',
    'Android Developer',
    'Junior Linux Systems Administrator',
    'iOS Engineer',
    'Insights Manager (New York City)',
    'Sales Development Manager',
    'Internship – Community Management Intern',
    'VP, Business Development',
    'QA Developer',
    'Senior Software Developer ',
    'Software Developer',
    'Editorial Intern',
    'Personal Finance Writer',
    'Data Analyst Intern',
    'Senior Product Manager',
    'Web Designer',
    'Senior Sales Engineer',
    'Enterprise Account Executive',
    'Product Marketing Manager',
    'Channel Marketing Manager',
    'Specialist, Website & SEO',
    'Marketing Automation Specialist',
    'Channel Sales',
    'Sr. Java Developer',
    'Infrastructure Development / DevOps Engineer',
    'Information Security Operations Engineer',
    'Client Services Manager',
    'Technical Support Manager',
    'Translation Services Manager',
    'VP Finance',
    'Client Services Intern',
    'Content & Communications Intern',
    'Creative Content Supervisor',
    'Creative Strategy Intern',
    'Design Intern',
    'Freelance Designer',
    'Freelance Flash Designer',
    'IT Intern',
    'Junior Video Editor',
    'Media Intern',
    'New Business Intern',
    'Part Time Billing Assistant',
    'Project Management Intern',
    'Senior Account Executive',
    'Senior Interactive Designer',
    'Desktop and Server Support - Field and Remote Technician',
    'SOFTWARE ENGINEER',
    'QA ENGINEER',
    'INSIDE SALES CONSULTANT',
    'Full-Stack Marketer (Growth)',
    'Head of Communications & PR',
    'Category Manager (Growth)',
    'Recruiter',
    'Engineer',
    'Front-End Engineer',
    'Content Education Producer',
    'VP of Engineering',
    'General Manager',
    'Content Acquisition Editor',
    'Community Manager (Support)',
    'Product Designer',
    'Internship',
    'Senior UI/UX Designer',
    'Senior Software Engineer - Big Data',
    'Lead Platform Architect',
    'Senior Software Engineer - Web Applications',
    'Sr Operations Engineer',
    'Advertising Operations Manager',
    'Advertising Sales Executive',
    'DIGITAL MERCHANDISING SPECIALIST',
    'INTERN',
    'UI DEVELOPER',
    'SOFTWARE ENGINEER',
    'PRODUCT MANAGER',
    'ACCOUNT MANAGER',
    'SALES ASSOCIATE',
    'Software Engineer',
    'ENGINEERS',
    'DATA SCIENTISTS',
    'DESIGNERS',
    'ACCOUNT SERVICES',
    'INTERNS',
    'Account Specialist',
    'Sales Director',
    'Director of Product Management',
    'Front End Web Developer',
    'Front end engineer',
    'Ruby on Rails Engineer',
    'Talented Generalist Engineer',
    'iOS Developer',
    'Director of Marketing',
    'Jr Online Marketing Analyst',
    'Product Manager - Conversion and On-Boarding Experience',
    'Product Manager - Handheld Apps',
    'Senior Director of Platform Products',
    'Visual Interaction Designer',
    'Customer Care Advisor',
    'eCommerce Associate',
    'WEB  DEVELOPER',
    'LEAD  IX  DESIGNER',
    'LEAD  iOS  DEVELOPER',
    'Sales Representative',
    'Internship',
    'Photography Internship',
    'Software Engineer',
    'UI Team Lead',
    'Engineering Team Lead',
    'Senior Database Engineer',
    'Head of Communications',
    'Community Outreach Coordinator',
    'Accounting & Finance Intern (part-time)',
    'Account Manager (AEC/SaaS)',
    'Lead UX Designer',
    'Regional Sales Manager (AEC/SaaS)',
    'Scala Developer for Green Building Software',
    'Sustainable Building Design Engineer / Architect',
    'Sustainable Building Design Engineer / Architect',
    'Software Engineer, Hadoop/Data team',
    'Software Engineer (Python)',
    'Quality Assurance (QA) Lead',
    'Interactive Project Manager',
    'Inside Sales Associate',
    'Sales Executive',
    'iOS Developer',
    'Android Developer',
    'Operations Engineer',
    'Frontend Developer',
    'Web Engineer',
    'Web & Mobile Designer',
    'Marketing Intern',
    'Sports Analyst Intern',
    'Marketing Associate',
    'Marketing Director - Bitcoin Investment Trust',
    'Account Executive',
    'Inside Sales Associate - Bitcoin Investment Trust',
    'Outside Sales Executive - Bitcoin Investment Trust',
    'Lead IOS Engineer',
    'Lead Server Side Engineer',
    'Design Intern',
    'Senior Web Application Developer',
    'Full Stack Software Engineer, Full-time',
    'Senior Account Executive',
    'Data Management Internship',
    'Social Media & SEO Intern',
    'Sr. Web Application Engineer',
    'Software Engineer - Mobile Application Development',
    'Database Administrator and Developer',
    'Paid Marketing Interns',
    'Infrastructure Architect',
    'Software Engineer (Web)',
    'Systems Engineer',
    'Product Manager, API & Integrations',
    'UI/UX Designer',
    'Account Executive (Bilingual Spanish) ',
    'Account Executives',
    'Conferences and Events Manager',
    'Client Success Manager',
    'Tech Recruiter' 
  ]
end