
(function (jQuery) {

	jQuery.fn.extend({
		silence: function () {
			this.each(function () {
				var form = jQuery(this);
				form.on('submit', function (ev) {
					ev.preventDefault();
					jQuery.post(form.attr('action'), form .serialize());
					return false;
				});
			});
			return this;
		}
	});

}(jQuery));

