<template>
    <div class="control-btn-group-parent">
        <div v-if="!isMenuVisible" class="d-flex justify-content-center control-btn-group">
            <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                ...
            </button>
            <div class="dropdown-menu">
                <button type="button" class="dropdown-item" @click="onUpClick">올리기</button>
                <button type="button" class="dropdown-item" @click="onDeleteClick">삭제</button>
                <button type="button" class="dropdown-item" @click="onDownClick">내리기</button>
            </div>
        </div>

        <div v-if="isMenuVisible" class="d-flex justify-content-center">
            <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                컨텐츠 추가
            </button>
            <div class="dropdown-menu">
                <button type="button" class="dropdown-item" @click="onNewPhotoClick">사진</button>
                <button type="button" class="dropdown-item" @click="onNewCardClick">카드</button>
                <button type="button" class="dropdown-item" @click="onNewTextClick">텍스트</button>
                <button type="button" class="dropdown-item" @click="onNewBtnClick">버튼</button>
            </div>
        </div>

        <input type="hidden" :name="formName('id')" :value="item.id">
        <input type="hidden" :name="formName('content_type')" :value="item.content_type">
        <input type="hidden" :name="formName('content_id')" :value="item.content_id">
        <input type="hidden" :name="formName('position')" :value="item.position">
        <input type="hidden" :name="formName('_destroy')" :value="item.destroy">

        <img v-if="isPhotoVisible" :src="item.img_url" class="img rounded">
        <input class="d-none" type="file" accept="image/*" multiple="multiple" @change="onFileChange" ref="imgFile" :name="formName('img')">
        <input class="d-none" type="text" :name="formName('img_url')" :value="item.img_url">
        <input v-if="isPhotoVisible" class="d-block form-control" placeholder="https://" type="text" v-model="item.link" :name="formName('link')">
        <textarea v-if="isPhotoVisible" class="d-block form-control" placeholder="사진 설명" v-model="item.content" :name="formName('content')"></textarea>

        <textarea v-if="isTextVisible" class="d-block form-control" placeholder="텍스트" v-model="item.content" :name="formName('content')"></textarea>

        <input v-if="isBtnVisible" class="d-block form-control text-center bg-primary text-white" placeholder="버튼 텍스트" type="text" v-model="item.content" :name="formName('content')">
        <input v-if="isBtnVisible" class="d-block form-control" placeholder="https://" type="text" v-model="item.link" :name="formName('link')">
    </div>
</template>

<script>
    export default {
        props: ['item'],
        data() {
            return {}
        },
        methods: {
            onUpClick() {
                this.$emit('up-item', this.item.position);
            },
            onDeleteClick() {
                this.$emit('delete-item', this.item.position);
            },
            onDownClick() {
                this.$emit('down-item', this.item.position);
            },
            onNewPhotoClick() {
                this.$refs.imgFile.click();
            },
            onFileChange(e) {
                const file = e.target.files[0];
                this.item.img_url = URL.createObjectURL(file);
                this.item.content_type = 'photo';

                this.$emit('add-new-item');
            },
            onNewCardClick() {
                this.$emit('show-card-select-modal');
            },
            onNewTextClick() {
                this.item.content_type = 'text';
                this.$emit('add-new-item');
            },
            onNewBtnClick() {
                this.item.content_type = 'button';
                this.$emit('add-new-item');
            },
            formName(attrName) {
                return 'advice[advice_contents][' + this.item.position + '][' + attrName + ']';
            },
        },
        computed: {
            isMenuVisible() {
                return this.item.content_type === '';
            },
            isPhotoVisible() {
                return this.item.content_type === 'photo' || this.item.content_type === 'card';
            },
            isTextVisible() {
                return this.item.content_type === 'text';
            },
            isBtnVisible() {
                return this.item.content_type === 'button';
            },
        }
    }
</script>

<style scoped>
    .img {
        margin: auto;
        border: 1px solid #BBBBBB;
        background: #eeeeee;
        width: 100%;
        height: 20rem;
        object-fit: cover;
        object-position: center;
    }

    .control-btn-group-parent {
        position: relative;
    }

    .control-btn-group {
        position: absolute;
        left: -100px;
    }
</style>
