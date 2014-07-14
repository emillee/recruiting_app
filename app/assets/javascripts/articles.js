var ready_articles = function() {

  if ($('.articles').length > 0) {


  	$('#new-link-a').on('click', function(e) {
  		e.preventDefault();
  		$('ul.links').prepend('<li id="new-link-li"></li>');
  		var form_url = '/articles/new';

  		$('#new-link-li').load(form_url + ' .new-job-li', function() {
  		});
  	});

    $('.article-link').on('click', function() {
      var $article_id = $(this).data('article-id');
      var $url = 'articles/' + $article_id + '/increase_views';
      var $selectorToUpdate = $('.views-count' + '.article-' + $article_id);

      $.ajax({
        type: 'PUT',
        url: $url,
        success: function() {
          var newViewCount = parseInt($selectorToUpdate.text()) + 1;
          console.log(newViewCount)
          $selectorToUpdate.text(newViewCount);
        }
      });
    });

    $('.recommend-link').on('click', function() {
      var $article_id = $(this).data('article-id');
      var $url = 'articles/' + $article_id + '/increase_recs';
      var $selectorToUpdate = $('.views-count' + '.article-' + $article_id);

      $.ajax({
        type: 'PUT',
        url: $url,
        success: function() {
          var newViewCount = parseInt($selectorToUpdate.text()) + 1;
          console.log(newViewCount)
          $selectorToUpdate.text(newViewCount);
        }
      });
    });

  };
};

$(document).ready(ready_articles);
$(document).on('page:load', ready_articles);  


