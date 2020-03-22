# 定义后缀
C_OR_CPP = cpp
# 定义源文件目录
SRC_DIR = src
VPATH += $(shell find $(SRC_DIR) -maxdepth 1 -type d)

# 集中管理 .o 文件
SRC_FILES := $(shell find $(SRC_DIR) -type f -iregex '.*\.$(C_OR_CPP)')
OBJ_FILES = $(SRC_FILES:.$(C_OR_CPP)=.o)

OUTPUT_DIR := debug
OUTPUT_OBJS = $(subst $(SRC_DIR),$(OUTPUT_DIR),$(OBJ_FILES))

# 定义输出文件名
TARGET = out

# 编译控制
# CPPFLAGS =

$(TARGET):$(OUTPUT_OBJS)
	$(CXX) $(OUTPUT_OBJS) -o $@

$(OUTPUT_DIR)/%.o : %.$(C_OR_CPP)
	$(CXX) $(CPPFLAGS) -c $< -o $@

# 伪目标
.PHNOY:clean mkdir
clean:
	-rm -f $(TARGET) $(OUTPUT_OBJS)

mkdir:
	$(shell find $(SRC_DIR) -type d | sed 's/$(SRC_DIR)/mkdir -p $(OUTPUT_DIR)/' | sh)
