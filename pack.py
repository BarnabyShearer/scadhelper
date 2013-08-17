#! /usr/bin/python3 -OO
# -*- coding: utf-8 -*-
#
# Pack 2d rectangles in a fast (but non-optimal) way.
#
# Copyright 2013 <b@Zi.is>
# License CC BY .30

import fileinput

class Rect(object):
    def __init__(self, name, x, y, w, h):
        self.name = name
        self.x = x
        self.y = y
        self.w = w
        self.h = h

    def area(self):
        return self.w * self.h

    def __repr__(self):
        return "%s %f %f" % (self.name, self.x, self.y)

class Node(Rect):

    def __init__(self, rect):
        self.name = None
        self.x = rect.x
        self.y = rect.y
        self.w = rect.w
        self.h = rect.h

        self.child_a = None
        self.child_b = None

    def insert(self, rect):
        if self.child_a and self.child_b:
            #Already devided so recurse
            return self.child_a.insert(rect) or self.child_b.insert(rect)

        if self.name or rect.w > self.w or rect.h > self.h:
            #Dosn't fit
            return None

        if self.w == rect.w and self.h == rect.h:
            #Perfect
            self.name = rect.name
            return self

        #Subdevide
        self.child_a = Node(self)
        self.child_b = Node(self)
        
        #Ensure child_a fits rect
        if self.w - rect.w > self.h - rect.h:
            self.child_a.w = rect.w
            self.child_b.x += rect.w
            self.child_b.w -= rect.w
        else:
            self.child_a.h = rect.h
            self.child_b.y += rect.h
            self.child_b.h -= rect.h

        return self.child_a.insert(rect)

def pack(rects):
    #Presorting in desending size give best results on average
    rects = sorted(rects, key = lambda rect: rect.area(), reverse = True)

    target = Rect(None, 0, 0, rects[0].w, rects[0].h)
    while True:
        try:
            placement = []
            tree = Node(target)
            for rect in rects:
                placed = tree.insert(rect)
                if not placed:
                    raise ValueError()
                placement.append(placed)
            break
        except ValueError:
            if target.w == target.h:
                target.w += 1
            else:
                target.h = target.w

    return placement

if __name__ == "__main__":
    rects = []
    for line in fileinput.input():
        if len(line.split(" ")) == 3:
            rects.append(
                Rect(
                    line.split(" ")[0],
                    0,
                    0,
                    float(line.split(" ")[1]),
                    float(line.split(" ")[2])
                )
            )

    for rect in pack(rects):
        print(rect)
