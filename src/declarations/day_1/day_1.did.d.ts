import type { Principal } from '@dfinity/principal';
export interface _SERVICE {
  'add' : (arg_0: bigint, arg_1: bigint) => Promise<bigint>,
  'add_to_array' : (arg_0: Array<bigint>, arg_1: bigint) => Promise<
      Array<bigint>
    >,
  'clear_counter' : () => Promise<bigint>,
  'days_to_second' : (arg_0: bigint) => Promise<bigint>,
  'divide' : (arg_0: bigint, arg_1: bigint) => Promise<boolean>,
  'getCounter' : () => Promise<bigint>,
  'increment_counter' : () => Promise<bigint>,
  'is_even' : (arg_0: bigint) => Promise<boolean>,
  'maximum' : (arg_0: Array<bigint>) => Promise<bigint>,
  'setCounter' : (arg_0: bigint) => Promise<undefined>,
  'square' : (arg_0: bigint) => Promise<bigint>,
  'sum_of_array' : (arg_0: Array<bigint>) => Promise<bigint>,
}
