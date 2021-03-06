{**
 * Выпадающее меню
 *
 * @param string name
 * @param string text
 * @param string classes
 * @param string attributes
 * @param string activeItem
 * @param array  items
 *}

{component 'nav'
	name       = ( $smarty.local.name ) ? "{$smarty.local.name}_menu" : ''
	activeItem = $smarty.local.activeItem
	mods       = 'stacked dropdown'
	classes    = "dropdown-menu {$smarty.local.classes}"
	attributes = array_merge( $smarty.local.attributes|default:[], [ 'id' => $smarty.local.id ] )
	items      = $smarty.local.items}