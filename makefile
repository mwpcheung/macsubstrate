CXX = clang++
CXXFLAGS = -Wall -std=c++17 -target x86_64-apple-macos10.12 -I./bsd -fPIC -fvisibility=default
LDFLAGS = -dynamiclib -install_name @rpath/$(DYNAMIC_LIB)


SOURCES_CPP = $(wildcard *.cpp)
SOURCES_MM = $(wildcard *.mm)
SOURCES = $(SOURCES_CPP) $(SOURCES_MM)

OBJECTS_CPP = $(SOURCES_CPP:.cpp=.o)
OBJECTS_MM = $(SOURCES_MM:.mm=.o)
OBJECTS = $(OBJECTS_CPP) $(OBJECTS_MM)

STATIC_LIB = libsubstrate.a
DYNAMIC_LIB = libsubstrate.dylib

all: $(STATIC_LIB) $(DYNAMIC_LIB)

$(STATIC_LIB): $(OBJECTS)
	ar rcs $@ $(OBJECTS)

$(DYNAMIC_LIB): $(OBJECTS)
	$(CXX) $(LDFLAGS) -o $@ $(OBJECTS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

%.o: %.mm
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -f $(OBJECTS_CPP) $(OBJECTS_MM) $(STATIC_LIB) $(DYNAMIC_LIB)

.PHONY: all clean
