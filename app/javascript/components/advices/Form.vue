<template>
    <div>
        <h1>{{ this.advice.id >= 1 ? '노하우 수정' : '노하우 쓰기'}}</h1>
        <form enctype="multipart/form-data" :action="actionUrl" accept-charset="UTF-8" method="post">
            <input name="utf8" type="hidden" value="✓">
            <input type="hidden" name="authenticity_token" :value="form_authenticity_token">
            <input type="hidden" name="_method" value="patch">

            <img :src="cover_url" class="cover rounded" @click="onCoverClick">
            <input class="d-none" type="file" accept="image/*" name="advice[cover]" multiple="multiple" @change="onFileChange" ref="coverFile">
            <input class="d-block form-control" v-model="subject" placeholder="제목" name="advice[title]">

            <FormContentItem class="mt-3" v-for="item in items" :item="item" v-show="!item.destroy" @show-card-select-modal="showCardSelectModal" @add-new-item="addNewItem" @up-item="upItem" @delete-item="deleteItem" @down-item="downItem"></FormContentItem>

            <div class="submit-wrapper d-flex justify-content-center">
                <input type="submit" class="btn btn-primary mt-3" name="commit" value="만들기">
            </div>
        </form>

        <!-- Button trigger modal -->
        <button type="button" class="btn btn-primary d-none" data-toggle="modal" data-target="#card-select-modal" ref="cardSelectModal"></button>

        <!-- Modal -->
        <div class="modal fade" id="card-select-modal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">카드 선택</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <img v-for="(item, idx) in my_cards" :src="item.img_url" @click="selectCard(item)" class="img" data-dismiss="modal">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import FormContentItem from "./FormContentItem";

    export default {
        components: {FormContentItem},
        props: ['form_authenticity_token', 'advice', 'advice_contents', 'my_cards'],
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
                this.advice_contents[i].destroy = false;
                this.items.push(this.advice_contents[i]);
            }
            for (let i = 0; i < this.my_cards.length; i++) {
                this.my_cards[i].img_url = this.my_cards[i].img_url0;
            }
            this.addNewItem();
        },
        methods: {
            onCoverClick(e) {
                if (!this.advice.id) {
                    this.$refs.coverFile.click();
                }
            },
            onFileChange(e) {
                const file = e.target.files[0];
                this.cover_url = URL.createObjectURL(file);
            },
            showCardSelectModal(position) {
                this.$refs.cardSelectModal.click();
            },
            addNewItem() {
                this.items.push({
                    id: 0,
                    advice_id: this.advice.id,
                    position: this.items.length,
                    content_type: '',
                    content_id: 0,
                    content: '',
                    img_url: '',
                    link: '',
                    destroy: false,
                });
            },
            selectCard(card) {
                const item = this.items[this.items.length - 1];
                item.img_url = card.img_url;
                item.content_type = 'card';
                item.content_id = card.id;
                item.link = window.location.origin + '/cards/' + card.id;
                item.content = card.content;
                this.items.splice(this.items.length - 1, 1, item);
                this.addNewItem();
            },
            upItem(position) {
                const belowIdx = this.items.findIndex(item => item.position === position);
                if (belowIdx == 0) {
                    return;
                }
                const aboveItem = this.items[belowIdx - 1];
                const belowItem = this.items[belowIdx];

                const tmpPosition = aboveItem.position;
                aboveItem.position = belowItem.position;
                belowItem.position = tmpPosition;

                this.items.splice(belowIdx - 1, 1, belowItem);
                this.items.splice(belowIdx, 1, aboveItem);
            },
            deleteItem(position) {
                const deleteIdx = this.items.findIndex(item => item.position === position);
                const deleteItem = this.items[deleteIdx];
                deleteItem.destroy = true;
                this.items.splice(deleteIdx, 1, deleteItem);
            },
            downItem(position) {
                const aboveIdx = this.items.findIndex(item => item.position === position);
                if (aboveIdx == this.items.length - 2) {
                    return;
                }
                const aboveItem = this.items[aboveIdx];
                const belowItem = this.items[aboveIdx + 1];

                const tmpPosition = aboveItem.position;
                aboveItem.position = belowItem.position;
                belowItem.position = tmpPosition;

                this.items.splice(aboveIdx, 1, belowItem);
                this.items.splice(aboveIdx + 1, 1, aboveItem);
            },
        },
        computed: {
            actionUrl() {
                if (this.advice.id >= 1) {
                    return '/advices/' + this.advice.id;
                } else {
                    return '/advices';
                }
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
