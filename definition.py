class Node(object):
    pass

class ClassDefinition(Node):
    def __init__(self, name, items):
        self.name = name
        self.items = items
    def __repr__(self):
        ret = []
        ret.append('(class ')
        ret.append(self.name)
        ret.append(', ')
        for item in self.items:
            ret.append(str(item))
            ret.append(', ')
        ret.pop()
        ret.append(')')
        return ''.join(ret)

class ClassMemberAttr(Node):
    def __init__(self, attr):
        self.attr = attr
    def __repr__(self):
        ret = []
        ret.append('(attr ')
        ret.append(self.attr)
        ret.append(')')        
        return ''.join(ret)

class Reg(Node):
    def __init__(self, name, msb, lsb):
        self.name = name
        self.msb = msb
        self.lsb = lsb
    def __repr__(self):
        ret = []
        ret.append('(Reg ')
        ret.append(self.name)
        ret.append(', ')
        ret.append(str(self.msb))
        ret.append(', ')
        ret.append(str(self.lsb))
        ret.append(')')
        return ''.join(ret)
