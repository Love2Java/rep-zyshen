﻿(function($) {
	tablist = {
		newTab : function(item) {
			var dataId = item.id;
			var dataUrl = item.url;
			var menuName = item.title;

			var flag = true;
			if (dataUrl == undefined || $.trim(dataUrl).length == 0) {
				return false;
			}
			$('.menuTab').each(
					function() {
						if ($(this).data('id') == dataUrl) {
							if (!$(this).hasClass('active')) {
								$(this).addClass('active').siblings('.menuTab')
										.removeClass('active');
								$.learuntab.scrollToTab(this);
								$('.mainContent .LRADMS_iframe').each(
										function() {
											if ($(this).data('id') == dataUrl) {
												$(this).show().siblings(
														'.LRADMS_iframe')
														.hide();
												return false;
											}
										});
							}
							flag = false;
							return false;
						}
					});
			if (flag) {
				var str = '<a href="javascript:;" class="active menuTab" data-id="'
						+ dataUrl
						+ '">'
						+ menuName
						+ ' <i class="fa fa-remove"></i></a>';
				$('.menuTab').removeClass('active');
				var str1 = '<iframe class="LRADMS_iframe" id="iframe' + dataId
						+ '" name="iframe' + dataId
						+ '"  width="100%" height="100%" src="' + dataUrl
						+ '" frameborder="0" data-id="' + dataUrl
						+ '" seamless></iframe>';
				$('.mainContent').find('iframe.LRADMS_iframe').hide();
				$('.mainContent').append(str1);
				// loading(true);
				$('.mainContent iframe:visible').load(function() {
					// loading(false);
				});
				$('.menuTabs .page-tabs-content').append(str);
				$.learuntab.scrollToTab($('.menuTab.active'));
			}
		}
	}
	$.learuntab = {
		requestFullScreen : function() {
			var de = document.documentElement;
			if (de.requestFullscreen) {
				de.requestFullscreen();
			} else if (de.mozRequestFullScreen) {
				de.mozRequestFullScreen();
			} else if (de.webkitRequestFullScreen) {
				de.webkitRequestFullScreen();
			}
		},
		exitFullscreen : function() {
			var de = document;
			if (de.exitFullscreen) {
				de.exitFullscreen();
			} else if (de.mozCancelFullScreen) {
				de.mozCancelFullScreen();
			} else if (de.webkitCancelFullScreen) {
				de.webkitCancelFullScreen();
			}
		},
		refreshTab : function() {
			var currentId = $('.page-tabs-content').find('.active').attr(
					'data-id');
			var target = $('.LRADMS_iframe[data-id="' + currentId + '"]');
			var url = target.attr('src');
			// loading(true);
			target.attr('src', url).load(function() {
				// loading(false);
			});
		},
		activeTab : function() {
			var currentId = $(this).data('id');
			if (!$(this).hasClass('active')) {
				$('.mainContent .LRADMS_iframe').each(function() {
					if ($(this).data('id') == currentId) {
						$(this).show().siblings('.LRADMS_iframe').hide();
						return false;
					}
				});
				$(this).addClass('active').siblings('.menuTab').removeClass(
						'active');
				$.learuntab.scrollToTab(this);
			}
		},
		closeOtherTabs : function() {
			$('.page-tabs-content').children("[data-id]").find('.fa-remove')
					.parents('a').not(".active").each(
							function() {
								$(
										'.LRADMS_iframe[data-id="'
												+ $(this).data('id') + '"]')
										.remove();
								$(this).remove();
							});
			$('.page-tabs-content').css("margin-left", "0");
		},
		closeTab : function() {
			var closeTabId = $(this).parents('.menuTab').data('id');
			var currentWidth = $(this).parents('.menuTab').width();
			if ($(this).parents('.menuTab').hasClass('active')) {
				if ($(this).parents('.menuTab').next('.menuTab').size()) {
					var activeId = $(this).parents('.menuTab').next(
							'.menuTab:eq(0)').data('id');
					$(this).parents('.menuTab').next('.menuTab:eq(0)')
							.addClass('active');

					$('.mainContent .LRADMS_iframe').each(function() {
						if ($(this).data('id') == activeId) {
							$(this).show().siblings('.LRADMS_iframe').hide();
							return false;
						}
					});
					var marginLeftVal = parseInt($('.page-tabs-content').css(
							'margin-left'));
					if (marginLeftVal < 0) {
						$('.page-tabs-content').animate({
							marginLeft : (marginLeftVal + currentWidth) + 'px'
						}, "fast");
					}
					$(this).parents('.menuTab').remove();
					$('.mainContent .LRADMS_iframe').each(function() {
						if ($(this).data('id') == closeTabId) {
							$(this).remove();
							return false;
						}
					});
				}
				if ($(this).parents('.menuTab').prev('.menuTab').size()) {
					var activeId = $(this).parents('.menuTab').prev(
							'.menuTab:last').data('id');
					$(this).parents('.menuTab').prev('.menuTab:last').addClass(
							'active');
					$('.mainContent .LRADMS_iframe').each(function() {
						if ($(this).data('id') == activeId) {
							$(this).show().siblings('.LRADMS_iframe').hide();
							return false;
						}
					});
					$(this).parents('.menuTab').remove();
					$('.mainContent .LRADMS_iframe').each(function() {
						if ($(this).data('id') == closeTabId) {
							$(this).remove();
							return false;
						}
					});
				}
			} else {
				$(this).parents('.menuTab').remove();
				$('.mainContent .LRADMS_iframe').each(function() {
					if ($(this).data('id') == closeTabId) {
						$(this).remove();
						return false;
					}
				});
				$.learuntab.scrollToTab($('.menuTab.active'));
			}
			return false;
		},
		addTab : function() {
			$(".navbar-custom-menu>ul>li.open").removeClass("open");
			var dataId = $(this).attr('data-id');

			var dataUrl = $(this).attr('href');
			var menuName = $.trim($(this).text());

			var flag = true;

			if (dataUrl == undefined || $.trim(dataUrl).length == 0 || dataUrl == "null") {
				return false;
			}
			if (dataUrl.indexOf("?") < 0) {
				dataUrl += "?a=1"
	        }
			dataUrl += "&pageID=" + dataId;
			dataUrl= ctx + dataUrl;
			var target = $(this).attr('target');
			if(target == undefined || $.trim(target).length == 0 || target == null) {
				target = "iframe";
			}
			if (target == "iframe") {
				$('.menuTab')
						.each(
								function() {
									if ($(this).data('id') == dataId) {
										if (!$(this).hasClass('active')) {
											$(this).addClass('active')
													.siblings('.menuTab')
													.removeClass('active');
											$.learuntab.scrollToTab(this);
											$('.mainContent .LRADMS_iframe')
													.each(
															function() {
																if ($(this)
																		.data(
																				'id') == dataId) {
																	$(this)
																			.show()
																			.siblings(
																					'.LRADMS_iframe')
																			.hide();
																	return false;
																}
															});
										}
										flag = false;
										return false;
									}
								});
				if (flag) {
					var str = '<a href="javascript:;" class="active menuTab" data-id="'
							+ dataId
							+ '">'
							+ menuName
							+ ' <i class="fa fa-remove"></i></a>';
					$('.menuTab').removeClass('active');
					var str1 = '<iframe class="LRADMS_iframe" id="iframe'
							+ dataId + '" name="iframe' + dataId
							+ '"  width="100%" height="100%" src="' + dataUrl
							+ '" frameborder="0" data-id="' + dataId
							+ '" seamless></iframe>';
					$('.mainContent').find('iframe.LRADMS_iframe').hide();
					$('.mainContent').append(str1);

					top.showMask();
					// loading(true);
					$('.mainContent iframe:visible').load(function() {
						// loading(false);
					});
					$('.menuTabs .page-tabs-content').append(str);
					$.learuntab.scrollToTab($('.menuTab.active'));
				}
			}
			else if(target=="window"){
				window.open(dataUrl,"_blank");
			}
			return false;
		},
		scrollTabRight : function() {
			var marginLeftVal = Math.abs(parseInt($('.page-tabs-content').css(
					'margin-left')));
			var tabOuterWidth = $.learuntab.calSumWidth($(".content-tabs")
					.children().not(".menuTabs"));
			var visibleWidth = $(".content-tabs").outerWidth(true)
					- tabOuterWidth;
			var scrollVal = 0;
			if ($(".page-tabs-content").width() < visibleWidth) {
				return false;
			} else {
				var tabElement = $(".menuTab:first");
				var offsetVal = 0;
				while ((offsetVal + $(tabElement).outerWidth(true)) <= marginLeftVal) {
					offsetVal += $(tabElement).outerWidth(true);
					tabElement = $(tabElement).next();
				}
				offsetVal = 0;
				while ((offsetVal + $(tabElement).outerWidth(true)) < (visibleWidth)
						&& tabElement.length > 0) {
					offsetVal += $(tabElement).outerWidth(true);
					tabElement = $(tabElement).next();
				}
				scrollVal = $.learuntab.calSumWidth($(tabElement).prevAll());
				if (scrollVal > 0) {
					$('.page-tabs-content').animate({
						marginLeft : 0 - scrollVal + 'px'
					}, "fast");
				}
			}
		},
		scrollTabLeft : function() {
			var marginLeftVal = Math.abs(parseInt($('.page-tabs-content').css(
					'margin-left')));
			var tabOuterWidth = $.learuntab.calSumWidth($(".content-tabs")
					.children().not(".menuTabs"));
			var visibleWidth = $(".content-tabs").outerWidth(true)
					- tabOuterWidth;
			var scrollVal = 0;
			if ($(".page-tabs-content").width() < visibleWidth) {
				return false;
			} else {
				var tabElement = $(".menuTab:first");
				var offsetVal = 0;
				while ((offsetVal + $(tabElement).outerWidth(true)) <= marginLeftVal) {
					offsetVal += $(tabElement).outerWidth(true);
					tabElement = $(tabElement).next();
				}
				offsetVal = 0;
				if ($.learuntab.calSumWidth($(tabElement).prevAll()) > visibleWidth) {
					while ((offsetVal + $(tabElement).outerWidth(true)) < (visibleWidth)
							&& tabElement.length > 0) {
						offsetVal += $(tabElement).outerWidth(true);
						tabElement = $(tabElement).prev();
					}
					scrollVal = $.learuntab
							.calSumWidth($(tabElement).prevAll());
				}
			}
			$('.page-tabs-content').animate({
				marginLeft : 0 - scrollVal + 'px'
			}, "fast");
		},
		scrollToTab : function(element) {
			var marginLeftVal = $.learuntab.calSumWidth($(element).prevAll()), marginRightVal = $.learuntab
					.calSumWidth($(element).nextAll());
			var tabOuterWidth = $.learuntab.calSumWidth($(".content-tabs")
					.children().not(".menuTabs"));
			var visibleWidth = $(".content-tabs").outerWidth(true)
					- tabOuterWidth;
			var scrollVal = 0;
			if ($(".page-tabs-content").outerWidth() < visibleWidth) {
				scrollVal = 0;
			} else if (marginRightVal <= (visibleWidth
					- $(element).outerWidth(true) - $(element).next()
					.outerWidth(true))) {
				if ((visibleWidth - $(element).next().outerWidth(true)) > marginRightVal) {
					scrollVal = marginLeftVal;
					var tabElement = element;
					while ((scrollVal - $(tabElement).outerWidth()) > ($(
							".page-tabs-content").outerWidth() - visibleWidth)) {
						scrollVal -= $(tabElement).prev().outerWidth();
						tabElement = $(tabElement).prev();
					}
				}
			} else if (marginLeftVal > (visibleWidth
					- $(element).outerWidth(true) - $(element).prev()
					.outerWidth(true))) {
				scrollVal = marginLeftVal - $(element).prev().outerWidth(true);
			}
			$('.page-tabs-content').animate({
				marginLeft : 0 - scrollVal + 'px'
			}, "fast");
		},
		calSumWidth : function(element) {
			var width = 0;
			$(element).each(function() {
				width += $(this).outerWidth(true);
			});
			return width;
		},
		init : function() {
			$('.menuItem').on('click', $.learuntab.addTab);
			$('.menuTabs').on('click', '.menuTab i', $.learuntab.closeTab);
			$('.menuTabs').on('click', '.menuTab', $.learuntab.activeTab);
			$('.tabLeft').on('click', $.learuntab.scrollTabLeft);
			$('.tabRight').on('click', $.learuntab.scrollTabRight);
			$('.tabReload').on('click', $.learuntab.refreshTab);
			$('.tabCloseCurrent').on('click', function() {
				$('.page-tabs-content').find('.active i').trigger("click");
			});
			$('.tabCloseAll').on(
					'click',
					function() {
						$('.page-tabs-content').children("[data-id]").find(
								'.fa-remove')
								.each(
										function() {
											$(
													'.LRADMS_iframe[data-id="'
															+ $(this)
																	.data('id')
															+ '"]').remove();
											$(this).parents('a').remove();
										});
						$('.page-tabs-content').children("[data-id]:first")
								.each(
										function() {
											$(
													'.LRADMS_iframe[data-id="'
															+ $(this)
																	.data('id')
															+ '"]').show();
											$(this).addClass("active");
										});
						$('.page-tabs-content').css("margin-left", "0");
					});
			$('.tabCloseOther').on('click', $.learuntab.closeOtherTabs);
			$('.fullscreen').on('click', function() {
				if (!$(this).attr('fullscreen')) {
					$(this).attr('fullscreen', 'true');
					$.learuntab.requestFullScreen();
				} else {
					$(this).removeAttr('fullscreen')
					$.learuntab.exitFullscreen();
				}
			});
		}
	};
	$.learunindex = {
		load : function() {
			$("body").removeClass("hold-transition")
			$("#content-wrapper").find('.mainContent').height(
					$(window).height() - $('.main-header').height()
							- $('.content-tabs').height());
			$(window).resize(
					function(e) {
						$("#content-wrapper").find('.mainContent').height(
								$(window).height() - $('.main-header').height()
										- $('.content-tabs').height());

					});
			$(".sidebar-toggle").click(function() {
				if (!$("body").hasClass("sidebar-collapse")) {
					$("body").addClass("sidebar-collapse");
				} else {
					$("body").removeClass("sidebar-collapse");
				}
			})
			$(window).load(function() {
				window.setTimeout(function() {
					$('#ajax-loader').fadeOut();
					// loading(false);
				}, 300);
			});
		},
		jsonWhere : function(data, action) {
			if (action == null)
				return;
			var reval = new Array();
			$(data).each(function(i, v) {
				if (action(v)) {
					reval.push(v);
				}
			})
			return reval;
		},
		loadMenu : function() {
			var data = [ ];
			$.ajax({
				url : ctx + "/user/getMenuList",
				type : "get",
				async: false,
				dataType : "json",
				success : function(data1) {
					data=data1;
				}
			});
			
			var _html = "";
			$
					.each(
							data,
							function(i) {
								var row = data[i];
								if (row.parentId == "1") {
									if (i == 0) {
										_html += '<li class="treeview active">';
									} else {
										_html += '<li class="treeview">';
									}
									_html += '<a style=\'cursor:pointer\'>'
									_html += '<i class="'
											+ row.icon
											+ '"></i><span>'
											+ row.name
											+ '</span><i class="fa fa-angle-left pull-right"></i>'
									_html += '</a>'
									var childNodes = $.learunindex
											.jsonWhere(
													data,
													function(v) {
														return v.parentId == row.id
													});
									if (childNodes.length > 0) {
										_html += '<ul class="treeview-menu">';
										$
												.each(
														childNodes,
														function(i) {
															var subrow = childNodes[i];
															var subchildNodes = $.learunindex
																	.jsonWhere(
																			data,
																			function(
																					v) {
																				return v.parentId == subrow.id
																			});
															_html += '<li>';
															if (subchildNodes.length > 0) {
																_html += '<a href="#" onclick="return false"><i class="'
																		+ subrow.icon
																		+ '"></i>'
																		+ subrow.name
																		+ '';
																_html += '<i class="fa fa-angle-left pull-right"></i></a>';
																_html += '<ul class="treeview-menu">';
																$
																		.each(
																				subchildNodes,
																				function(
																						i) {
																					var subchildNodesrow = subchildNodes[i];
																					var target111 = "";
																					if(null != subchildNodesrow.target) {
																						target111 = subchildNodesrow.target;
																					}
																					_html += '<li><a class="menuItem" target="'
																							+ target111
																							+ '" data-id="'
																							+ subchildNodesrow.id
																							+ '" href="'
																							+ subchildNodesrow.href
																							+ '"><i class="'
																							+ subchildNodesrow.icon
																							+ '"></i>'
																							+ subchildNodesrow.name
																							+ '</a></li>';
																				});
																_html += '</ul>';

															} else {
																var target222 = "";
																if(null != subrow.target) {
																	target222 = subrow.target;
																}
																_html += '<a class="menuItem" target="'
																		+ target222
																		+ '"  data-id="'
																		+ subrow.id
																		+ '" href="'
																		+ subrow.href
																		+ '"><i class="'
																		+ subrow.icon
																		+ '"></i>'
																		+ subrow.name
																		+ '</a>';
															}
															_html += '</li>';
														});
										_html += '</ul>';
									}
									_html += '</li>'
								}
							});
			$("#sidebar-menu").append(_html);
			$("#sidebar-menu li a")
					.click(
							function() {
								var d = $(this), e = d.next();
								if (e.is(".treeview-menu") && e.is(":visible")) {

									e.slideUp(100, function() {
										e.removeClass("menu-open")
									}), e.parent("li").removeClass("active");
									$(e.find(".treeview-menu"))
											.each(
													function() {
														$(this)
																.slideUp(
																		100,
																		function() {
																					$(
																							this)
																							.removeClass(
																									"menu-open"),
																					$(
																							this)
																							.parent(
																									"li")
																							.removeClass(
																									"active");
																		});

													});
								} else if (e.is(".treeview-menu")
										&& !e.is(":visible")) {
									var f = d.parents("ul").first(), g = f
											.find("ul:visible").slideUp(100);
									g.removeClass("menu-open");
									var h = d.parent("li");
									e.slideDown(100,
											function() {
												e.addClass("menu-open"), f
														.find("li.active")
														.removeClass("active"),
														h.addClass("active");

											})

								}

								e.is(".treeview-menu");
							});
		},
		indexOut : function() {
			dialogConfirm("注：您确定要安全退出本次登录吗？", function(r) {
				if (r) {
					// loading(true, "正在安全退出...");
					window.setTimeout(function() {
						$.ajax({
							url : contentPath + "/Login/OutLogin",
							type : "post",
							dataType : "json",
							success : function(data) {
								window.location.href = contentPath
										+ "/Login/Index2";
							}
						});
					}, 500);
				}
			});
		}
	};
	$(function() {
		$.learunindex.load();
		$.learunindex.loadMenu();
		$.learuntab.init();
	});
})(jQuery);
// 初始化导航
