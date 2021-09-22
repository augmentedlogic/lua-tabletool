--[[
    Copyright (c) 2018 Wolfgang Hauptfleisch <dev@augmentedlogic.com>

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.
    --]]
    local _M = {}

    ---
    -- simple rounding to n decinal places
    --
    function round(num, decimal_places)
        local mult = 10^(decimal_places or 0)
    return math.floor(num * mult + 0.5) / mult
    end

    ---
    -- check if a value is numeric
    --
    local function is_numeric(value)
       if tonumber(value) then
        return true
       end
       return false
    end

    ---
    -- generate a randomseed, uses /dev/urandom on linux and a simple time based value
    -- on systems where urandom is not available
    --
    local function urandom()
        local r = ""

        local devurandom = io.open("/dev/urandom", "rb")
        if devurandom then
            local s = devurandom:read(16)
            devurandom:close()
            local e = #s
            for p=1, e do
               local c = string.byte(string.sub(s, p))
               r = r .. c 
            end
        else 
            r = os.clock() * os.clock() * os.time()
        end 
    return tonumber(r)
    end

    ---
    -- make a copy of a table
    --
    local function shallow_copy(t)
       local t2 = {}
         for k,v in pairs(t) do
         t2[k] = v
         end
         return t2
    end

    ---
    -- generate a random integer between min/max
    --
    local function random_int(min, max)
        math.randomseed(urandom())
    return math.random(min, max)
    end


    ---
    -- normalize the numeric values of a table between 0 and 1
    --
    function _M.normalize(tt)
       local t_new = {}
       local min = math.min(unpack(tt))
       local max = math.max(unpack(tt))
       for _, v in ipairs(tt) do
         table.insert(t_new, (v-min)/(max-min))
       end
    return t_new
    end

    ---
    -- denormalize the numeric values of a table between min and max
    --
    function _M.denormalize(tt, min, max)
       local t_new = {}
       for _, v in ipairs(tt) do
         table.insert(t_new, v * (max - min) + min)
       end
    return t_new
    end


    ---
    -- shuffle the values of a table randomly
    --
    function _M.shuffle(tbl)
        local new_t = shallow_copy(tbl) 
        for i = #tbl, 2, -1 do
            math.randomseed(urandom())
            local j = math.random(i)
            new_t[i], new_t[j] = new_t[j], new_t[i]
        end
    return new_t
    end

    ---
    -- caculate the sum of nummeric values in a table
    --
    function _M.sum(t)
        local s = 0
        for _,v in ipairs(t) do
            if is_numeric(v) then
              s = s + v 
            end
        end
    return s
    end

    ---
    -- fetch a random value from a table
    --
    function _M.get_random_element(t)
    return t[random_int(1, #t)]    
    end

    ---
    -- calculate the average of nummeric values in a table
    --
    function _M.average(t, d)
        local s = 0
        for k,v in pairs(t) do
                s = s + v 
        end
        local r = s/#t
        if d then
           r = round(r, d)
        end
    return r
    end

    --
    -- reverse the order of a table
    --
    function _M.reverse(tt)
        local new_t = shallow_copy(tt);
        local n = #new_t
        local i = 1
        while i < n do
            new_t[i],new_t[n] = new_t[n],new_t[i]
            i = i + 1
            n = n - 1
        end
    return new_t
    end


    ------
    -- count the occurance of an value in a table
    --
    function _M.count_element(tt, value)
        local count = 0
        for ii,xx in pairs(tt) do
            if xx == value then count = count + 1 end
        end
    return count
    end

    ------
    -- check if a value in a table exists
    --
    function _M.contains(tt, value)
        for k,v in pairs(tt) do
            if v == value then
               return true
            end
        end
    return false
    end

    ------
    -- sort a table with numeric values, descending
    --
    function _M.sort_desc(tt)
      local new_t = shallow_copy(tt)
      table.sort(new_t, function(a, b) return a > b end)
      return new_t;
    end


    ------
    -- sort a table with numeric values, ascending
    --
    function _M.sort_asc(tt)
      local new_t = shallow_copy(tt)
      table.sort(new_t)
      return new_t;
    end


    ------
    -- join two tables (keeps identical entries)
    --
    function _M.join(t1, t2)
        local t = {}
        for k in pairs(t1) do
            table.insert(t, t1[k])
        end
        for k in pairs(t2) do
            table.insert(t, t2[k])
        end
    return t
    end

    --
    -- create a table with only unique elements
    --
    function _M.unique(tt)
        local newtable = {}
        for ii,xx in pairs(tt) do
            if _M.count_element(newtable, xx) == 0 then
                newtable[#newtable+1] = xx
            end
        end
    return newtable
    end


    ---
    -- get a slice from a table, by offset and length
    ---
    function _M.slice(t, offset, length)
        local new_t = {}
            if offset + length > #t - offset then
               length =  #t - offset
            end
            local c = 1
            for i=offset + 1, offset + length do
                new_t[c] = t[i]
                c = c + 1
            end
    return new_t
    end

    --
    -- for debugging purpose, dump the table structure 
    --
    function _M.dumptable(t, indent)
        local indent=indent or ''
        for key,value in pairs(t) do
            io.write(indent,'[',tostring(key),']')
            if type(value)=="table" then io.write(':\n') _M.dumptable(value,indent..'\t')
            else io.write(' = ',tostring(value),'\n') end
        end
    end

    return _M

