namespace CsrfProtect;

class CsrfProtect
{
	const POST_KEY = "_csrf";
	const SESSION_PREFIX = "_csrf_";
	const TOKEN_LENGTH = 32;
	const TOKEN_CHARS = "azertyuiopqsdfghjklmwxcvbnAZERTYUIOPQSDFGHJKLMWXCVBN1234567890_-";
	const TOKENS_LIMIT = 5000;

	public static function checkPostToken(string identifier = "") -> boolean
	{
		if empty _POST[CsrfProtect::POST_KEY] {
			return false;
		}

		return self::checkToken(_POST[CsrfProtect::POST_KEY], identifier);
	}

	public static function getTokenIndex(string token = "", string identifier = "") -> int | string | boolean
	{
		if ! session_id() {
			session_start();
		}

		if empty token {
			if empty _POST[CsrfProtect::POST_KEY] {
				return false;
			}
			let token = (string) _POST[CsrfProtect::POST_KEY];
		}

		if empty _SESSION[CsrfProtect::SESSION_PREFIX . identifier] {
			return false;
		}

		if is_array(_SESSION[CsrfProtect::SESSION_PREFIX . identifier]) {
			return array_search(token, _SESSION[CsrfProtect::SESSION_PREFIX . identifier]);
		}

		return false;
	}

	public static function checkToken(string token = "", string identifier = "") -> boolean
	{
		var key;
		let key = self::getTokenIndex(token, identifier);

		if key !== false {
			unset(_SESSION[CsrfProtect::SESSION_PREFIX . identifier][key]);
			return true;
		}

		return false;
	}

	public static function getToken(string identifier = "") -> string
	{
		if ! session_id() {
			session_start();
		}

		string token = "";
		int charsCount = strlen(CsrfProtect::TOKEN_CHARS);
		int i = 0;
		while i < CsrfProtect::TOKEN_LENGTH {
			let token .= substr(CsrfProtect::TOKEN_CHARS, mt_rand(0, charsCount), 1);
			let i = i + 1;
		}

		if empty _SESSION[CsrfProtect::SESSION_PREFIX . identifier] {
			let _SESSION[CsrfProtect::SESSION_PREFIX . identifier] = [];
		} else {
			while count(_SESSION[CsrfProtect::SESSION_PREFIX . identifier]) > CsrfProtect::TOKENS_LIMIT {
				array_shift(_SESSION[CsrfProtect::SESSION_PREFIX . identifier]);
			}
		}
		array_push(_SESSION[CsrfProtect::SESSION_PREFIX . identifier], token);

		return token;
	}

	public static function getTag(string identifier = "") -> string
	{
		return "<input " .
			"type=\"hidden\" " .
			"name=\"" . CsrfProtect::POST_KEY . "\" " .
			"value=\"" . self::getToken(identifier) . "\"" .
		">";
	}
}
