
/* This file was generated automatically by Zephir do not modify it! */

#ifndef PHP_CSRFPROTECT_H
#define PHP_CSRFPROTECT_H 1

#ifdef PHP_WIN32
#define ZEPHIR_RELEASE 1
#endif

#include "kernel/globals.h"

#define PHP_CSRFPROTECT_NAME        "csrfprotect"
#define PHP_CSRFPROTECT_VERSION     "0.0.1"
#define PHP_CSRFPROTECT_EXTNAME     "csrfprotect"
#define PHP_CSRFPROTECT_AUTHOR      ""
#define PHP_CSRFPROTECT_ZEPVERSION  "0.9.2a-dev"
#define PHP_CSRFPROTECT_DESCRIPTION ""



ZEND_BEGIN_MODULE_GLOBALS(csrfprotect)

	int initialized;

	/* Memory */
	zephir_memory_entry *start_memory; /**< The first preallocated frame */
	zephir_memory_entry *end_memory; /**< The last preallocate frame */
	zephir_memory_entry *active_memory; /**< The current memory frame */

	/* Virtual Symbol Tables */
	zephir_symbol_table *active_symbol_table;

	/** Function cache */
	HashTable *fcache;

	zephir_fcall_cache_entry *scache[ZEPHIR_MAX_CACHE_SLOTS];

	/* Cache enabled */
	unsigned int cache_enabled;

	/* Max recursion control */
	unsigned int recursive_lock;

	/* Global constants */
	zval *global_true;
	zval *global_false;
	zval *global_null;
	
ZEND_END_MODULE_GLOBALS(csrfprotect)

#ifdef ZTS
#include "TSRM.h"
#endif

ZEND_EXTERN_MODULE_GLOBALS(csrfprotect)

#ifdef ZTS
	#define ZEPHIR_GLOBAL(v) TSRMG(csrfprotect_globals_id, zend_csrfprotect_globals *, v)
#else
	#define ZEPHIR_GLOBAL(v) (csrfprotect_globals.v)
#endif

#ifdef ZTS
	#define ZEPHIR_VGLOBAL ((zend_csrfprotect_globals *) (*((void ***) tsrm_ls))[TSRM_UNSHUFFLE_RSRC_ID(csrfprotect_globals_id)])
#else
	#define ZEPHIR_VGLOBAL &(csrfprotect_globals)
#endif

#define ZEPHIR_API ZEND_API

#define zephir_globals_def csrfprotect_globals
#define zend_zephir_globals_def zend_csrfprotect_globals

extern zend_module_entry csrfprotect_module_entry;
#define phpext_csrfprotect_ptr &csrfprotect_module_entry

#endif
