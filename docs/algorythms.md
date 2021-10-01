

### Interface vs Data Structure
* Interface (API/ADI)
    - specification
    - what data can store
    - what operation are supported (what they mean)
    - problem

* 2 main interfaces
    - set
    - sequence [2,47,34,78]

* Static sequence interface
    maintain a sequence of items x0,x1,x2, ..., Xn-1 subject to these operations

* Data Structure
    - representation
    - how to store data
    - algorithms to support operations
    - solution

* 2 main data structure approach
    - arrays
    - pointer based

### Interface to DS
#### Probleme: Static sequence (interface)
A generic approach
    - build(X) make new DS for tiems in X
    - len() return n
    - iter_seq() output x0,x1, etc... , Xn-1 in sequence order (linear time)
    - get_at(i) return Xi (i for index of)
    - set_at(i,x) set Xi to X
    - get_first()/get_last()
    - set_first(X)/set_last()

#### Solution: Static array (DS)
    relate to word RAM model of computation
    - memory = array of w-bit words => [0x...][][][address:0x242abc45.. store value:X][][][]...
    - array = consecutive chunk of memory bit
    - offset arithmatics => array[i] = memory[address(array)+i]
    - array access = contant time 0(1)
So
    - O(1) per get_at() | set_at() | len()
    - O(n) per build() | iter_seq
This is Memory allocation model : allocate array of size n in O(n) time
 => space = O(time)

#### Probleme: Dynamic sequence (interface)
    - all static sequence method +
    - insert_at(i,x) make x the new Xi 
    - delete_at(i)
    - insert/delete first/last

#### Solution: linked lists
    - Storage in node
    - Nodes are all array of size 2 [item, pointer]

    HEAD
        [Item, -> pointer to random item]( random as in RAM(randomly accessed on))
        ,[Item, ->] 
        ,[Item, Next] -> None
    TAIL

    - head -> to -> tail -> len

### Comparison : Dynamic sequence operations problem

#### Static array
    Insert_at() and Delete_at(), which are dynamic operations, takes constant time operation
    Still Possible
    - Shifting all elements takes O(n), the time of all elements...
        you need to copy all elements to a new array
    - Reallocation/copying of all the array + the new element
    - Either first and last insertion require reallocation
#### Linked list
    Insert_at()/Delete_at(), depends
    - On first, change the head pointer to new element and new element pointer to point to the last first element
    - On last, or get,set at need O(indexof) time
        worst case O(n)
    - On last, you can add a tail pointer to the last element that need to be

#### Solution: Dynamic arrays (aka python's interpreter's lists )
    - Relax constraint size(array) = n <- #item in the seq :
       ```Allocate more memory based on further operations to come
          relaxing size...mean that [1,2,3,4, ,, , ,,,]```
    - enforce size = O(n) at most(au plus) & >= n
    - maintain A[i] =Xi
    - len(inserted item) vs size(real physical mem allocation)
    - if len = size => no more space
When n = size?
    - allocate new array of size n what? 2 * size
    - insert till -> (resize+copy) at size 1,2,4,8,16 ... +n
    - Cost O(1+2+4+8 ... +n)
           O(sumof 1 to N  )
        (Amortization) => Quand une operation coute plus cher que les autres,
                            on peut dire que la plus couteuse est repartie sur celle qui ne coute rien
                            , ou dans ce cas-ci dynamic array is costing
                            => averaging over operation sequence

## Problem set
































