extends Node

var setted_up: bool = false

func execute_javascript_global_setup() -> void:
	JavaScript.eval("""
	
function getPlatform() {
	var ios_devices = [
		'iPhone', 'iPad', 'iPod', "MacIntel"
	];

	var platform = "unknown";
	var UserAgent = window.navigator.userAgent;

	if (/Android/.test(UserAgent) || ios_devices.indexOf(window.navigator.platform) !== -1) {
		platform = "mobile";
	} else {
		platform = "desktop";
	}
	
	return platform;
	
}

// Found at:
// https://developer.mozilla.org/en-US/docs/Web/API/Web_Storage_API/Using_the_Web_Storage_API

function storageAvailable(type) {
	var storage;
	try {
		storage = window[type];
		var x = '__storage_test__';
		storage.setItem(x, x);
		storage.removeItem(x);
		return true;
	}
	catch(e) {
		return e instanceof DOMException && (
			// everything except Firefox
			e.code === 22 ||
			// Firefox
			e.code === 1014 ||
			// test name field too, because code might not be present
			// everything except Firefox
			e.name === 'QuotaExceededError' ||
			// Firefox
			e.name === 'NS_ERROR_DOM_QUOTA_REACHED') &&
			// acknowledge QuotaExceededError only if there's something already stored
			(storage && storage.length !== 0);
	}
}

function saveValue(key, value) {
	if (storageAvailable('localStorage')) {
		localStorage.setItem(key, value);
	}
}
function loadValue(key) {
	if (storageAvailable('localStorage')) {
		return localStorage.getItem(key);
	}
}
function clearStorage() {
	if (storageAvailable('localStorage')) {
		localStorage.clear();
	}
}
""", true)

func clear_storage() -> void: JavaScript.eval("clearStorage();")
func save_value(key, value): JavaScript.eval("saveValue('%s', %s)" % [key, value])
func load_value(key):
	var value = JavaScript.eval("loadValue('%s')" % key)
	return value 
