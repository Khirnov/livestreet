/**
 * Стена пользователя
 *
 * @module ls/wall
 *
 * @license   GNU General Public License, version 2
 * @copyright 2013 OOO "ЛС-СОФТ" {@link http://livestreetcms.com}
 * @author    Denis Shakhov <denis.shakhov@gmail.com>
 */

(function($) {
	"use strict";

	$.widget( "livestreet.lsWall", {
		/**
		 * Дефолтные опции
		 */
		options: {
			// Ссылки
			urls: {
				add:           null,
				remove:        null,
				load:          null,
				load_comments: null
			},

			// Селекторы
			selectors: {
				entry: {
					self:   '.js-wall-entry',
					remove: '.js-comment-remove',
					reply:  '.js-comment-reply'
				},
				comment:          '.js-wall-comment',
				post:             '.js-wall-post',
				form:             '.js-wall-form',
				more:             '.js-wall-more',
				more_comments:    '.js-wall-more-comments',
				comment_wrapper:  '.js-wall-comment-wrapper',
				container:        '.js-wall-entry-container',
				empty:            '.js-wall-alert-empty'
			}
		},

		/**
		 * Конструктор
		 *
		 * @constructor
		 * @private
		 */
		_create: function () {
			var _this = this;

			this.elements = {
				empty:         this.element.find( this.option( 'selectors.empty'         ) ),
				more:          this.element.find( this.option( 'selectors.more'          ) ),
				more_comments: this.element.find( this.option( 'selectors.more_comments' ) ),
				entries:       this.element.find( this.option( 'selectors.entry.self'    ) ),
				forms:         this.element.find( this.option( 'selectors.form'          ) ),
				container:     this.element.find( this.option( 'selectors.container'     ) )
			};

			this.userId = this.getUserId();

			// Подгрузка новых постов
			this.elements.more.lsMore({
				url: this.option( 'urls.load' ),
				params: {
					user_id: this.getUserId()
				}
			});

			// Подгрузка комментариев
			this.elements.more_comments.livequery( function () {
				$( this ).lsMore({
					url: _this.option( 'urls.load_comments' ),
					params: {
						user_id: _this.getUserId()
					}
				});
			});

			// Записи
			this.elements.entries.livequery( function () {
				$( this ).lsWallEntry({
					wall: _this.element,
					urls: {
						remove: _this.option( 'urls.remove' )
					},
					selectors: {
						wrapper: _this.option( 'selectors.comment_wrapper' ),
						remove:  _this.option( 'selectors.entry.remove' ),
						reply:   _this.option( 'selectors.entry.reply' ),
					}
				})
			});

			// Формы
			this.elements.forms.livequery( function () {
				$( this ).lsWallForm({
					wall: _this.element
				});
			});
		},

		/**
		 * Добавление
		 *
		 * TODO: Оптимизировать
		 */
		add: function( pid, text ) {
			var form = this.getFormById( pid );

			ls.ajax.load( this.option( 'urls.add' ), { user_id: this.getUserId(), pid: pid, text: text }, function( response ) {
				if ( response.bStateError ) {
					ls.msg.error(null, response.sMsg);
				} else {
					if ( pid === 0 ) this.elements.empty.hide();

					this.load( pid );
					form.lsWallForm( 'close' );
				}

				ls.utils.formUnlock( form );
			}.bind(this));
		},

		/**
		 * Подгружает записи
		 *
		 * TODO: Оптимизировать
		 */
		load: function( pid ) {
			var container = this.element.find( this.options.selectors.container + '[data-id=' + pid + ']' ),
				firstId   = container.find( '>' + this.option( 'selectors.entry.self' ) + ':' + ( pid === 0 ? 'first' : 'last' ) ).data( 'id' ) || -1,
				params    = { user_id: this.getUserId(), first_id: firstId, target_id: pid };

			ls.ajax.load( this.option( pid === 0 ? 'urls.load' : 'urls.load_comments' ), params, function( response ) {
				if (response.bStateError) {
					ls.msg.error(null, response.sMsg);
				} else {
					if ( response.count_loaded ) {
						container[ pid === 0 ? 'prepend' : 'append' ]( response.html );
					}
				}
			}.bind(this));
		},

		/**
		 * Получает посты
		 */
		getPosts: function() {
			return this.element.find( this.option( 'selectors.post' ) );
		},

		/**
		 * Получает комментарии по ID поста
		 */
		getCommentsByPostId: function( pid ) {
			return this.getCommentWrapperById( pid ).find( this.option( 'selectors.comment' ) );
		},

		/**
		 * Получает запись по ID
		 */
		getEntryById: function( id ) {
			return this.element.find( this.option( 'selectors.entry.self' ) + '[data-id=' + id + ']' ).eq( 0 );
		},

		/**
		 * Получает враппер комментариев по ID поста
		 */
		getCommentWrapperById: function( id ) {
			return this.element.find( this.option( 'selectors.comment_wrapper' ) + '[data-id=' + id + ']' ).eq( 0 );
		},

		/**
		 * Получает форму по ID поста
		 */
		getFormById: function( id ) {
			return this.element.find( this.option( 'selectors.form' ) + '[data-id=' + id + ']' ).eq( 0 );
		},

		/**
		 * Получает ID владельца стены
		 */
		getUserId: function() {
			return this.userId ? this.userId : this.userId = this.element.data( 'user-id' );
		},

		/**
		 * Получает развернутые формы
		 */
		getOpenedForms: function() {
			return this.element.find( this.option( 'selectors.form' ) + '.' + ls.options.classes.states.open );
		},

		/**
		 * Проверяет и если нужно показывает/скрывает сообщение о пустом списке
		 */
		checkEmpty: function() {
			this.elements.empty[ this.getPosts().length ? 'hide' : 'show' ]();
		}
	});
})(jQuery);