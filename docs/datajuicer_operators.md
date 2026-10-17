# Data-Juicer v1.5.0 全部算子总览 / Data-Juicer Operators

> **来源**：Data-Juicer 官方 v1.5.0，[完整页面](https://datajuicer.github.io/data-juicer/en/v1.5.0/docs/Operators.html)
> **统计**：aggregator(4) + deduplicator(10) + filter(56) + formatter(8) + grouper(3) + mapper(103) + pipeline(3) + selector(5) = **192**，对外宣传 200+
> **用途**：DataVerse Phase 1 对标基准，同名算子等价实现 + 结果比对校准

## 一、aggregator 聚合算子（4）

1. global_aggregator
2. list_aggregator
3. math_aggregator
4. summary_aggregator

## 二、deduplicator 去重算子（10）

1. document_deduplicator
2. image_deduplicator
3. minhash_deduplicator
4. ray_document_deduplicator
5. ray_image_deduplicator
6. ray_minhash_deduplicator
7. ray_simhash_deduplicator
8. simhash_deduplicator
9. exact_deduplicator
10. ray_exact_deduplicator

## 三、filter 过滤算子（56）

### 文本类 filter（22）

1. alphanumeric_filter
2. average_line_length_filter
3. character_repetition_filter
4. flagged_words_filter
5. language_id_score_filter
6. maximum_line_length_filter
7. perplexity_filter
8. special_characters_filter
9. stopwords_filter
10. text_length_filter
11. token_num_filter
12. word_num_filter
13. word_repetition_filter
14. chinese_chars_ratio_filter
15. english_chars_ratio_filter
16. numeric_ratio_filter
17. punctuation_ratio_filter
18. duplicate_sentence_filter
19. high_quality_paragraph_filter
20. toxic_content_filter
21. safety_score_filter
22. llm_quality_score_filter

### 图像类 filter（10）

23. image_aesthetics_filter
24. image_aspect_ratio_filter
25. image_face_ratio_filter
26. image_nsfw_filter
27. image_shape_filter
28. image_size_filter
29. image_watermark_filter
30. image_existence_filter
31. image_ocr_area_filter
32. image_ocr_text_filter

### 音频类 filter（5）

33. audio_duration_filter
34. audio_nmf_snr_filter
35. audio_size_filter
36. audio_spectrogram_filter
37. audio_volume_filter

### 视频类 filter（9）

38. video_aesthetics_filter
39. video_aspect_ratio_filter
40. video_duration_filter
41. video_existence_filter
42. video_frame_num_filter
43. video_nsfw_filter
44. video_resolution_filter
45. video_size_filter
46. video_watermark_filter

### 多模态通用 filter（10）

47. caption_text_filter
48. entity_count_filter
49. keyword_count_filter
50. metadata_filter
51. sample_score_filter
52. action_filter
53. trace_coherence_filter
54. agent_bad_case_filter
55. url_filter
56. date_filter

## 四、formatter 数据加载/格式化算子（8）

1. empty_formatter
2. json_formatter
3. local_formatter
4. parquet_formatter
5. remote_formatter
6. text_formatter
7. tsv_formatter
8. csv_formatter

## 五、grouper 分组算子（3）

1. key_value_grouper
2. naive_grouper
3. naive_reverse_grouper

## 六、mapper 转换/增强/改写算子（103）

### 文本清洗 & 规范化（21）

1. chinese_convert_mapper
2. clean_copyright_mapper
3. clean_email_mapper
4. clean_html_mapper
5. clean_ip_mapper
6. clean_links_mapper
7. fix_unicode_mapper
8. punctuation_normalization_mapper
9. whitespace_normalization_mapper
10. remove_bibliography_mapper
11. remove_comments_mapper
12. remove_header_mapper
13. remove_long_words_mapper
14. remove_non_chinese_character_mapper
15. remove_repeat_sentences_mapper
16. remove_specific_chars_mapper
17. remove_table_text_mapper
18. remove_words_with_incorrect_substrings_mapper
19. replace_content_mapper
20. sentence_split_mapper
21. text_chunk_mapper

### QA/LLM 生成、优化、抽取（21）

22. calibrate_qa_mapper
23. calibrate_query_mapper
24. calibrate_response_mapper
25. extract_entity_relation_mapper
26. extract_event_mapper
27. extract_keyword_mapper
28. extract_nickname_mapper
29. extract_support_text_mapper
30. extract_tables_from_html_mapper
31. generate_qa_from_examples_mapper
32. generate_qa_from_text_mapper
33. llm_extract_mapper
34. latex_merge_tex_mapper
35. latex_figure_context_extractor_mapper
36. optimize_prompt_mapper
37. optimize_qa_mapper
38. optimize_query_mapper
39. optimize_response_mapper
40. pair_preference_mapper
41. relation_identity_mapper
42. text_tagging_by_prompt_mapper

### 文本增强（3）

43. nlpaug_en_mapper
44. nlpcda_zh_mapper
45. sentence_augmentation_mapper

### 意图、情感、主题识别（4）

46. dialog_intent_detection_mapper
47. query_intent_detection_mapper
48. query_sentiment_detection_mapper
49. query_topic_detection_mapper

### 自定义脚本（2）

50. python_file_mapper
51. python_lambda_mapper

### 对象存储（2）

52. s3_download_file_mapper
53. s3_upload_file_mapper

### 图像算子（17）

54. image_blur_mapper
55. image_captioning_from_gpt4v_mapper
56. image_captioning_mapper
57. image_detection_yolo_mapper
58. image_diffusion_mapper
59. image_face_blur_mapper
60. image_mmpose_mapper
61. image_remove_background_mapper
62. image_sam_3d_body_mapper
63. image_segment_mapper
64. image_tagging_mapper
65. image_tagging_vlm_mapper
66. imgdiff_difference_area_generator_mapper
67. imgdiff_difference_caption_generator_mapper
68. detect_character_attributes_mapper
69. detect_character_locations_mapper
70. detect_main_character_mapper

### 多模态 VLM（2）

71. mllm_mapper
72. sdxl_prompt2prompt_mapper

### 音频算子（2）

73. audio_add_gaussian_noise_mapper
74. audio_ffmpeg_wrapped_mapper

### 视频算子（26）

75. vggt_mapper
76. video_camera_calibration_static_deepcalib_mapper
77. video_camera_calibration_static_moge_mapper
78. video_camera_pose_mapper
79. video_captioning_from_audio_mapper
80. video_captioning_from_frames_mapper
81. video_captioning_from_summarizer_mapper
82. video_captioning_from_video_mapper
83. video_captioning_from_vlm_mapper
84. video_depth_estimation_mapper
85. video_extract_frames_mapper
86. video_face_blur_mapper
87. video_ffmpeg_wrapped_mapper
88. video_hand_reconstruction_hawor_mapper
89. video_hand_reconstruction_mapper
90. video_object_segmenting_mapper
91. video_remove_watermark_mapper
92. video_resize_aspect_ratio_mapper
93. video_resize_resolution_mapper
94. video_split_by_duration_mapper
95. video_split_by_key_frame_mapper
96. video_split_by_scene_mapper
97. video_tagging_from_audio_mapper
98. video_tagging_from_frames_mapper
99. video_undistort_mapper
100. video_whole_body_pose_estimation_mapper

### Agent 相关 mapper（3）

101. agent_tool_type_mapper
102. agent_trace_coherence_mapper
103. human_preference_annotation_mapper

## 七、pipeline 数据集级流水线算子（3）

1. global_statistics_pipeline
2. histogram_pipeline
3. sampler_pipeline

## 八、selector 样本筛选算子（5）

1. topk_selector
2. threshold_selector
3. balance_selector
4. sort_selector
5. stratified_selector

---

## DataVerse 14 类 ↔ DJ 8 大类映射

| DataVerse 类 | DJ 大类 | DJ 算子数 | 对标说明 |
|-------------|---------|-----------|----------|
| ① Ingest | formatter | 8 | json/csv/tsv/parquet/text_formatter |
| ② Normalize | mapper（清洗规范化） | ~5 | whitespace/punctuation_normalization, fix_unicode, chinese_convert |
| ③ Clean | mapper（清洗） | ~15 | clean_email/html/ip/links, remove_bibliography/comments/header/table_text |
| ④ Dedup | deduplicator | 10 | exact/minhash/simhash/document/image dedup（含 ray 分布式） |
| ⑤ Filter | filter | 56 | 文本 22 + 图像 10 + 音频 5 + 视频 9 + 多模态 10 |
| ⑥ Quality | filter（质量）+ mapper（LLM 质量） | ~5 | llm_quality_score, high_quality_paragraph, perplexity, safety_score |
| ⑦ Transform | mapper（增强+图像+音频+视频） | ~40 | nlpaug, image_*, video_*, audio_* |
| ⑧ Annotate | mapper（QA/抽取+意图+标注） | ~25 | extract_*, calibrate_*, intent_detection, text_tagging, generate_qa |
| ⑨ Select | selector | 5 | topk/threshold/balance/sort/stratified |
| ⑩ Mix | grouper + aggregator | 7 | key_value/naive_grouper, global/list/math/summary_aggregator |
| ⑪ Pack | formatter（输出）+ pipeline | 3 | sampler_pipeline, histogram, text_chunk |
| ⑫ Eval | pipeline + aggregator | 4 | global_statistics, histogram_pipeline, summary/math_aggregator |
| ⑬ Lineage | —（DJ 无） | 0 | DataVerse 独有：datatemporal 版本塔/血缘/回放 |
| ⑭ Safety | filter（安全）+ mapper（脱敏） | ~5 | toxic_content, image_nsfw, face_blur, clean_email/ip |

## 对标优先级（Phase 1 S1.1）

1. **P0 高频对标**：text_length_filter, exact_deduplicator, whitespace_normalization_mapper, clean_html_mapper, topk_selector
2. **P1 文本清洗线**：clean_email/ip/links_mapper, remove_comments/header_mapper, fix_unicode_mapper, punctuation_normalization_mapper
3. **P2 过滤线**：word_num/token_num/alphabetic/special_characters/word_repetition_filter
4. **P3 多模态**：image_size/aspect_ratio_filter, image_captioning_mapper — Phase 2

## DJ 算子命名规范

`<功能>_filter` / `<功能>_mapper` / `<功能>_deduplicator` / `<功能>_selector` / `<功能>_formatter` / `<功能>_grouper` / `<功能>_aggregator` / `<功能>_pipeline`。DataVerse 同名实现保持下划线命名，便于 recipe 互导。

---

> Data-Juicer Operators Reference | v1.5.0 | 2026-10-17