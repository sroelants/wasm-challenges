;; Like char_search_ascii but now you also need to know how to handle UTF-8
;; encoded strings. Within UTF-8 strings, a single character can be encoded as
;; multiple bytes, so you'll need to handle the > U+0080 range correctly to
;; pass the tests.
