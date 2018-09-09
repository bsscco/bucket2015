<template>
    <div>
        <img v-if="isPhotoVisible" :src="item.img_url" class="img rounded">
        <a v-if="isPhotoVisible" class="d-block" :href="item.link"> {{ item.link }}</a>
        <p v-if="isPhotoVisible" class="d-block" >{{ item.content }}</p>

        <p v-if="isTextVisible" class="d-block" >{{ item.content }}</p>

        <a v-if="isBtnVisible" class="d-block text-center bg-primary text-white p-3 rounded" :href="item.link">{{ item.content }}</a>
    </div>
</template>

<script>
    export default {
        props: ['item'],
        data() {
            return {}
        },
        methods: {
        },
        computed: {
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
</style>
