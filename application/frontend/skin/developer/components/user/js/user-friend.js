/**
 * Add friend
 *
 * @module ls/user/friend
 *
 * @license   GNU General Public License, version 2
 * @copyright 2013 OOO "ЛС-СОФТ" {@link http://livestreetcms.com}
 * @author    Denis Shakhov <denis.shakhov@gmail.com>
 */

(function($) {
	"use strict";

	$.widget( "livestreet.lsUserFriend", {
		/**
		 * Дефолтные опции
		 */
		options: {
			// Ссылки
			urls: {
				// Добавить в друзья
				add: null,

				// Удалить из друзей
				remove: null,

				// Подтвердить
				accept: null,

				// Модальное окно с формой добавления
				modal: null
			},
			selectors: {
				form: '.js-user-friend-form',
				text: '.js-user-friend-text'
			}
		},

		/**
		 * Конструктор
		 *
		 * @constructor
		 * @private
		 */
		_create: function () {
			this.target = this.element.data( 'target' );

			this._on({ click: this.onClick });
		},

		/**
		 * Коллбэк вызываемый при клике на кнопку добавления в друзья
		 */
		onClick: function( event ) {
			var status = this.getStatus();

			if ( status == 'notfriends' ) {
				this.showForm();
			} else if ( status == 'pending' ) {
				this.accept();
			} else if ( status == 'added' ) {
				this.remove();
			} else if ( status == 'linked' ) {
				this.addLinked();
			}

			event.stopPropagation();
			event.preventDefault();
		},

		/**
		 * Получение статуса
		 */
		getStatus: function() {
			return this.element.attr( 'data-status' );
		},

		/**
		 * Установка статуса
		 */
		setStatus: function( status ) {
			var textElement = this.element.find( this.option( 'selectors.text' ) ),
				textClass = this.option( 'selectors.text' ).slice( 1 );

			if ( ~ [ 'sent', 'rejected' ].indexOf( status ) ) {
				textElement.replaceWith( '<span class="' + textClass + '">' + ls.lang.get( 'user.friends.status.' + status ) + '</span>' );
			} else {
				textElement.replaceWith( '<a href="#" class="' + textClass + '">' + ls.lang.get( 'user.friends.status.' + status ) + '</a>' );
			}

			this.element.attr( 'data-status', status );
		},

		/**
		 * Показывает форму
		 */
		showForm: function() {
			var _this = this;

			ls.modal.load( this.option( 'urls.modal' ), { target: this.target }, {
				aftershow: function( e, modal ) {
					var form = modal.element.find( _this.option( 'selectors.form' ) ),
						textarea = form.find( _this.option( 'selectors.text' ) );

					textarea.focus();

					form.on( 'submit', function ( event ) {
						var text = textarea.val();

						ls.utils.formLock( form );

						ls.ajax.load( _this.option( 'urls.add' ), {
							idUser: _this.target,
							userText: text
						}, function( response ) {
							ls.utils.formUnlock( form );

							if ( response.bStateError ) {
								ls.msg.error( null, response.sMsg );
							} else {
								ls.msg.notice( null, response.sMsg );

								modal.hide();
								_this.setStatus( 'sent' );
							}
						});

						event.preventDefault();
					}.bind(this))
				}
			});
		},

		/**
		 * Повторное подтверждение
		 */
		addLinked: function() {
			this.accept( this.option( 'urls.add' ) );
		},

		/**
		 * Подтверждение
		 */
		accept: function( url ) {
			ls.ajax.load( url || this.option( 'urls.accept' ), {
				idUser: this.target,
			}, function( response ) {
				if ( response.bStateError ) {
					ls.msg.error( null, response.sMsg );
				} else {
					ls.msg.notice( null, response.sMsg );

					this.setStatus( 'added' );
				}
			}.bind(this));
		},

		/**
		 * Удаление из друзей
		 */
		remove: function() {
			ls.ajax.load( this.option( 'urls.remove' ), {
				idUser: this.target
			}, function( response ) {
				if ( response.bStateError ) {
					ls.msg.error(null,response.sMsg);
				} else {
					ls.msg.notice(null,response.sMsg);

					this.setStatus( 'linked' );
				}
			}.bind(this));
		}
	});
})(jQuery);