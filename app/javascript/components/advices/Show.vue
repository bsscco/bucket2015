<template>
    <div>
        <h1>{{ subject }}</h1>
        <img :src="cover_url" class="cover rounded">

        <ShowContentItem class="mt-3" v-for="item in items" :item="item"></ShowContentItem>

        <div v-if="is_mine" class="mt-3">
            <a :href="editPath">수정</a>
            <a :href="deletePath" data-method="delete" data-confirm="진짜?">삭제</a>
        </div>
    </div>
</template>

<script>
    import ShowContentItem from "./ShowContentItem";

    export default {
        components: {ShowContentItem},
        props: ['advice', 'advice_contents', 'is_mine'],
        data: function () {
            return {
                cover_url: null,
                subject: '',
                items: [],
            }
        },
        created() {
            this.cover_url = this.advice.cover_url0;
            this.subject = this.advice.title;
            for (let i = 0; i < this.advice_contents.length; i++) {
                this.advice_contents[i].img_url = this.advice_contents[i].img_url0;
                this.items.push(this.advice_contents[i]);
            }
        },
        methods: {},
        computed: {
            editPath() {
                return window.location.origin + '/advices/' + this.advice.id + '/edit';
            },
            deletePath() {
                return window.location.origin + '/advices/' + this.advice.id;
            },
        }
    }
</script>

<style scoped>
    .cover {
        margin: auto;
        border: 1px solid #BBBBBB;
        background: #eeeeee;
        width: 100%;
        height: 20rem;
        object-fit: cover;
        object-position: center;
    }
</style>
