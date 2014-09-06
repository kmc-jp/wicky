
wicky.projects = {};

(function (ui, projects, jQuery) {

	var views = {};

	projects.main = function () {
		uiEditorPreview();
		uiFormBind();
	};

	/**
	 * focus した textarea でプレビューを有効にする．
	 * 動的に追加された textarea 要素も対象．
	 */
	function uiEditorPreview () {
		var editables = new WeakMap();
		jQuery(document).on('focus', 'textarea', function (ev) {
			var target = jQuery(ev.target);
			if (editables.has(ev.target)) {
				return;
			}
			if (target.is('form.modify-summary textarea[name="summary"]')
			 || target.is('form.modify-schedule textarea[name="description"]')) {
				ui.editable(target);
				editables.set(ev.target, true);
			}
		});
	}

	/**
	 * data-binder を設定してある form から submit したときに，
	 * 紐づけてあるビューを更新する．
	 */
	function uiFormBind () {
		jQuery(document).on('submit', 'form', function (ev) {
			var form = jQuery(ev.target), config = {}, binder;
			if (!form.is('form[data-binder]')) {
				return;
			}
			ev.preventDefault();
			binder = ui.binder(form.data('binder'));
			if (form.is('form.modify-summary')) {
				/**
				 * TODO: '/projects/:id/!show' を実装して summary だけでなく name も置き換えるように
				 */
				jQuery.extend(config, {
					data: {
						md: form.find('textarea[name="summary"]').val()
					}
				});
			}
			jQuery.post(form.attr('action'), form.serialize()).done(function () {
				binder.update(config);
			});
			return false;
		});
	}

}(wicky.ui, wicky.projects, jQuery));

