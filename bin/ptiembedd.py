#!/usr/bin/env python
"""
"""
import asyncio

import IPython
from ptpython.ipython import embed

loop = asyncio.get_event_loop()
# def main():
#     embed(vi_mode=True)


async def interactive_shell():
    """
    Coroutine that starts a Python REPL from which we can access the global
    counter variable.
    """
    print(
        'You should be able to read and update the "counter[0]" variable from this shell.'
    )
    try:
        await embed(vi_mode=True, return_asyncio_coroutine=True, patch_stdout=True)
    except EOFError:
        # Stop the loop when quitting the repl. (Ctrl-D press.)
        loop.stop()


def main():
    asyncio.ensure_future(interactive_shell())

    loop.run_forever()
    loop.close()


if __name__ == "__main__":
    main()
