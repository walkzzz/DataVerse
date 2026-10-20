///===
/// extcore/nlp_embed_doc2vec

pub(all) struct Nlpembeddoc2vecPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_embed_doc2vec_make_point(x : Double, y : Double) -> Nlpembeddoc2vecPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_embed_doc2vec_make_point3(x : Double, y : Double, z : Double) -> Nlpembeddoc2vecPoint {
  { x, y, z, label: 0 }
}

pub fn Nlpembeddoc2vecPoint::x(self : Nlpembeddoc2vecPoint) -> Double { self.x }

pub fn Nlpembeddoc2vecPoint::y(self : Nlpembeddoc2vecPoint) -> Double { self.y }

pub fn Nlpembeddoc2vecPoint::z(self : Nlpembeddoc2vecPoint) -> Double { self.z }

pub fn Nlpembeddoc2vecPoint::label(self : Nlpembeddoc2vecPoint) -> Int { self.label }

pub fn Nlpembeddoc2vecPoint::dist(self : Nlpembeddoc2vecPoint, other : Nlpembeddoc2vecPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Nlpembeddoc2vecPoint::add(self : Nlpembeddoc2vecPoint, other : Nlpembeddoc2vecPoint) -> Nlpembeddoc2vecPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Nlpembeddoc2vecPoint::sub(self : Nlpembeddoc2vecPoint, other : Nlpembeddoc2vecPoint) -> Nlpembeddoc2vecPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Nlpembeddoc2vecPoint::scale(self : Nlpembeddoc2vecPoint, s : Double) -> Nlpembeddoc2vecPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Nlpembeddoc2vecPoint::dot(self : Nlpembeddoc2vecPoint, other : Nlpembeddoc2vecPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Nlpembeddoc2vecPoint::cross(self : Nlpembeddoc2vecPoint, other : Nlpembeddoc2vecPoint) -> Nlpembeddoc2vecPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Nlpembeddoc2vecPoint::norm(self : Nlpembeddoc2vecPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Nlpembeddoc2vecPoint::normalize(self : Nlpembeddoc2vecPoint) -> Nlpembeddoc2vecPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Nlpembeddoc2vecPoint::negate(self : Nlpembeddoc2vecPoint) -> Nlpembeddoc2vecPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Nlpembeddoc2vecPoint::mid(self : Nlpembeddoc2vecPoint, other : Nlpembeddoc2vecPoint) -> Nlpembeddoc2vecPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Nlpembeddoc2vecPoint::lerp(self : Nlpembeddoc2vecPoint, other : Nlpembeddoc2vecPoint, t : Double) -> Nlpembeddoc2vecPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Nlpembeddoc2vecPoint::to_string(self : Nlpembeddoc2vecPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_embed_doc2vec_make_series(vals : Array[Double], name : String) -> Nlpembeddoc2vecSeries {
  { vals, name, meta: 0 }
}

pub fn Nlpembeddoc2vecSeries::len(self : Nlpembeddoc2vecSeries) -> Int { self.vals.length() }

pub fn Nlpembeddoc2vecSeries::sum(self : Nlpembeddoc2vecSeries) -> Double { @_common.sum(self.vals) }

pub fn Nlpembeddoc2vecSeries::mean(self : Nlpembeddoc2vecSeries) -> Double { @_common.mean(self.vals) }

pub fn Nlpembeddoc2vecSeries::min(self : Nlpembeddoc2vecSeries) -> Double { @_common.min(self.vals) }

pub fn Nlpembeddoc2vecSeries::max(self : Nlpembeddoc2vecSeries) -> Double { @_common.max(self.vals) }

pub fn Nlpembeddoc2vecSeries::range(self : Nlpembeddoc2vecSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Nlpembeddoc2vecSeries::variance(self : Nlpembeddoc2vecSeries) -> Double { @_common.variance(self.vals) }

pub fn Nlpembeddoc2vecSeries::std(self : Nlpembeddoc2vecSeries) -> Double { @_common.std(self.vals) }

pub fn Nlpembeddoc2vecSeries::median(self : Nlpembeddoc2vecSeries) -> Double { @_common.median(self.vals) }

pub fn Nlpembeddoc2vecSeries::scale(self : Nlpembeddoc2vecSeries, f : Double) -> Nlpembeddoc2vecSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Nlpembeddoc2vecSeries::add(self : Nlpembeddoc2vecSeries, other : Nlpembeddoc2vecSeries) -> Nlpembeddoc2vecSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Nlpembeddoc2vecSeries::sub(self : Nlpembeddoc2vecSeries, other : Nlpembeddoc2vecSeries) -> Nlpembeddoc2vecSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Nlpembeddoc2vecSeries::normalize(self : Nlpembeddoc2vecSeries) -> Nlpembeddoc2vecSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Nlpembeddoc2vecSeries::cumsum(self : Nlpembeddoc2vecSeries) -> Nlpembeddoc2vecSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Nlpembeddoc2vecSeries::to_string(self : Nlpembeddoc2vecSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Nlpembeddoc2vecMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_embed_doc2vec_make_matrix(rows : Int, cols : Int, val : Double) -> Nlpembeddoc2vecMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn nlp_embed_doc2vec_matrix_identity(n : Int) -> Nlpembeddoc2vecMatrix {
  let m = nlp_embed_doc2vec_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Nlpembeddoc2vecMatrix::get(self : Nlpembeddoc2vecMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Nlpembeddoc2vecMatrix::transpose(self : Nlpembeddoc2vecMatrix) -> Nlpembeddoc2vecMatrix {
  let result = nlp_embed_doc2vec_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Nlpembeddoc2vecMatrix::add(self : Nlpembeddoc2vecMatrix, other : Nlpembeddoc2vecMatrix) -> Nlpembeddoc2vecMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_embed_doc2vec_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Nlpembeddoc2vecMatrix::scale(self : Nlpembeddoc2vecMatrix, s : Double) -> Nlpembeddoc2vecMatrix {
  let result = nlp_embed_doc2vec_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Nlpembeddoc2vecMatrix::multiply(self : Nlpembeddoc2vecMatrix, other : Nlpembeddoc2vecMatrix) -> Nlpembeddoc2vecMatrix {
  if self.cols != other.rows { return nlp_embed_doc2vec_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_embed_doc2vec_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn Nlpembeddoc2vecMatrix::trace(self : Nlpembeddoc2vecMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Nlpembeddoc2vecMatrix::det(self : Nlpembeddoc2vecMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Nlpembeddoc2vecMatrix::norm(self : Nlpembeddoc2vecMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Nlpembeddoc2vecMatrix::to_string(self : Nlpembeddoc2vecMatrix) -> String {
  let mut result = "Mat(" + self.rows.to_string() + "x" + self.cols.to_string() + ")\n"
  let rl = if self.rows < 5 { self.rows } else { 5 }
  let cl = if self.cols < 5 { self.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + @_common.dbl(self.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct Nlpembeddoc2vecVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_embed_doc2vec_make_vector(comps : Array[Double]) -> Nlpembeddoc2vecVector {
  { comps, dim: comps.length() }
}

pub fn nlp_embed_doc2vec_vector_zero(dim : Int) -> Nlpembeddoc2vecVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Nlpembeddoc2vecVector::add(self : Nlpembeddoc2vecVector, other : Nlpembeddoc2vecVector) -> Nlpembeddoc2vecVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Nlpembeddoc2vecVector::sub(self : Nlpembeddoc2vecVector, other : Nlpembeddoc2vecVector) -> Nlpembeddoc2vecVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Nlpembeddoc2vecVector::scale(self : Nlpembeddoc2vecVector, s : Double) -> Nlpembeddoc2vecVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Nlpembeddoc2vecVector::dot(self : Nlpembeddoc2vecVector, other : Nlpembeddoc2vecVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Nlpembeddoc2vecVector::norm(self : Nlpembeddoc2vecVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Nlpembeddoc2vecVector::normalize(self : Nlpembeddoc2vecVector) -> Nlpembeddoc2vecVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Nlpembeddoc2vecVector::dist(self : Nlpembeddoc2vecVector, other : Nlpembeddoc2vecVector) -> Double {
  self.sub(other).norm()
}

pub fn Nlpembeddoc2vecVector::to_string(self : Nlpembeddoc2vecVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Nlpembeddoc2vecFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_frame_make(size : Int) -> Nlpembeddoc2vecFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Nlpembeddoc2vecFrame::len(self : Nlpembeddoc2vecFrame) -> Int { self.size }

pub fn Nlpembeddoc2vecFrame::get(self : Nlpembeddoc2vecFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Nlpembeddoc2vecFrame::set(self : Nlpembeddoc2vecFrame, i : Int, v : Double) -> Nlpembeddoc2vecFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecFrame::sum(self : Nlpembeddoc2vecFrame) -> Double { @_common.sum(self.data) }

pub fn Nlpembeddoc2vecFrame::mean(self : Nlpembeddoc2vecFrame) -> Double { @_common.mean(self.data) }

pub fn Nlpembeddoc2vecFrame::scale(self : Nlpembeddoc2vecFrame, f : Double) -> Nlpembeddoc2vecFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecFrame::add(self : Nlpembeddoc2vecFrame, other : Nlpembeddoc2vecFrame) -> Nlpembeddoc2vecFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Nlpembeddoc2vecFrame::copy(self : Nlpembeddoc2vecFrame) -> Nlpembeddoc2vecFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecFrame::fill(self : Nlpembeddoc2vecFrame, v : Double) -> Nlpembeddoc2vecFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecFrame::min(self : Nlpembeddoc2vecFrame) -> Double { @_common.min(self.data) }

pub fn Nlpembeddoc2vecFrame::max(self : Nlpembeddoc2vecFrame) -> Double { @_common.max(self.data) }

pub fn Nlpembeddoc2vecFrame::to_string(self : Nlpembeddoc2vecFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_table_make(size : Int) -> Nlpembeddoc2vecTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Nlpembeddoc2vecTable::len(self : Nlpembeddoc2vecTable) -> Int { self.size }

pub fn Nlpembeddoc2vecTable::get(self : Nlpembeddoc2vecTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Nlpembeddoc2vecTable::set(self : Nlpembeddoc2vecTable, i : Int, v : Double) -> Nlpembeddoc2vecTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecTable::sum(self : Nlpembeddoc2vecTable) -> Double { @_common.sum(self.data) }

pub fn Nlpembeddoc2vecTable::mean(self : Nlpembeddoc2vecTable) -> Double { @_common.mean(self.data) }

pub fn Nlpembeddoc2vecTable::scale(self : Nlpembeddoc2vecTable, f : Double) -> Nlpembeddoc2vecTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecTable::add(self : Nlpembeddoc2vecTable, other : Nlpembeddoc2vecTable) -> Nlpembeddoc2vecTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Nlpembeddoc2vecTable::copy(self : Nlpembeddoc2vecTable) -> Nlpembeddoc2vecTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecTable::fill(self : Nlpembeddoc2vecTable, v : Double) -> Nlpembeddoc2vecTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecTable::min(self : Nlpembeddoc2vecTable) -> Double { @_common.min(self.data) }

pub fn Nlpembeddoc2vecTable::max(self : Nlpembeddoc2vecTable) -> Double { @_common.max(self.data) }

pub fn Nlpembeddoc2vecTable::to_string(self : Nlpembeddoc2vecTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_graphn_make(size : Int) -> Nlpembeddoc2vecGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Nlpembeddoc2vecGraphN::len(self : Nlpembeddoc2vecGraphN) -> Int { self.size }

pub fn Nlpembeddoc2vecGraphN::get(self : Nlpembeddoc2vecGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Nlpembeddoc2vecGraphN::set(self : Nlpembeddoc2vecGraphN, i : Int, v : Double) -> Nlpembeddoc2vecGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecGraphN::sum(self : Nlpembeddoc2vecGraphN) -> Double { @_common.sum(self.data) }

pub fn Nlpembeddoc2vecGraphN::mean(self : Nlpembeddoc2vecGraphN) -> Double { @_common.mean(self.data) }

pub fn Nlpembeddoc2vecGraphN::scale(self : Nlpembeddoc2vecGraphN, f : Double) -> Nlpembeddoc2vecGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecGraphN::add(self : Nlpembeddoc2vecGraphN, other : Nlpembeddoc2vecGraphN) -> Nlpembeddoc2vecGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Nlpembeddoc2vecGraphN::copy(self : Nlpembeddoc2vecGraphN) -> Nlpembeddoc2vecGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecGraphN::fill(self : Nlpembeddoc2vecGraphN, v : Double) -> Nlpembeddoc2vecGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecGraphN::min(self : Nlpembeddoc2vecGraphN) -> Double { @_common.min(self.data) }

pub fn Nlpembeddoc2vecGraphN::max(self : Nlpembeddoc2vecGraphN) -> Double { @_common.max(self.data) }

pub fn Nlpembeddoc2vecGraphN::to_string(self : Nlpembeddoc2vecGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_node_make(size : Int) -> Nlpembeddoc2vecNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Nlpembeddoc2vecNode::len(self : Nlpembeddoc2vecNode) -> Int { self.size }

pub fn Nlpembeddoc2vecNode::get(self : Nlpembeddoc2vecNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Nlpembeddoc2vecNode::set(self : Nlpembeddoc2vecNode, i : Int, v : Double) -> Nlpembeddoc2vecNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecNode::sum(self : Nlpembeddoc2vecNode) -> Double { @_common.sum(self.data) }

pub fn Nlpembeddoc2vecNode::mean(self : Nlpembeddoc2vecNode) -> Double { @_common.mean(self.data) }

pub fn Nlpembeddoc2vecNode::scale(self : Nlpembeddoc2vecNode, f : Double) -> Nlpembeddoc2vecNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecNode::add(self : Nlpembeddoc2vecNode, other : Nlpembeddoc2vecNode) -> Nlpembeddoc2vecNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Nlpembeddoc2vecNode::copy(self : Nlpembeddoc2vecNode) -> Nlpembeddoc2vecNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecNode::fill(self : Nlpembeddoc2vecNode, v : Double) -> Nlpembeddoc2vecNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecNode::min(self : Nlpembeddoc2vecNode) -> Double { @_common.min(self.data) }

pub fn Nlpembeddoc2vecNode::max(self : Nlpembeddoc2vecNode) -> Double { @_common.max(self.data) }

pub fn Nlpembeddoc2vecNode::to_string(self : Nlpembeddoc2vecNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_edge_make(size : Int) -> Nlpembeddoc2vecEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Nlpembeddoc2vecEdge::len(self : Nlpembeddoc2vecEdge) -> Int { self.size }

pub fn Nlpembeddoc2vecEdge::get(self : Nlpembeddoc2vecEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Nlpembeddoc2vecEdge::set(self : Nlpembeddoc2vecEdge, i : Int, v : Double) -> Nlpembeddoc2vecEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecEdge::sum(self : Nlpembeddoc2vecEdge) -> Double { @_common.sum(self.data) }

pub fn Nlpembeddoc2vecEdge::mean(self : Nlpembeddoc2vecEdge) -> Double { @_common.mean(self.data) }

pub fn Nlpembeddoc2vecEdge::scale(self : Nlpembeddoc2vecEdge, f : Double) -> Nlpembeddoc2vecEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecEdge::add(self : Nlpembeddoc2vecEdge, other : Nlpembeddoc2vecEdge) -> Nlpembeddoc2vecEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Nlpembeddoc2vecEdge::copy(self : Nlpembeddoc2vecEdge) -> Nlpembeddoc2vecEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecEdge::fill(self : Nlpembeddoc2vecEdge, v : Double) -> Nlpembeddoc2vecEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecEdge::min(self : Nlpembeddoc2vecEdge) -> Double { @_common.min(self.data) }

pub fn Nlpembeddoc2vecEdge::max(self : Nlpembeddoc2vecEdge) -> Double { @_common.max(self.data) }

pub fn Nlpembeddoc2vecEdge::to_string(self : Nlpembeddoc2vecEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_path_make(size : Int) -> Nlpembeddoc2vecPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Nlpembeddoc2vecPath::len(self : Nlpembeddoc2vecPath) -> Int { self.size }

pub fn Nlpembeddoc2vecPath::get(self : Nlpembeddoc2vecPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Nlpembeddoc2vecPath::set(self : Nlpembeddoc2vecPath, i : Int, v : Double) -> Nlpembeddoc2vecPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecPath::sum(self : Nlpembeddoc2vecPath) -> Double { @_common.sum(self.data) }

pub fn Nlpembeddoc2vecPath::mean(self : Nlpembeddoc2vecPath) -> Double { @_common.mean(self.data) }

pub fn Nlpembeddoc2vecPath::scale(self : Nlpembeddoc2vecPath, f : Double) -> Nlpembeddoc2vecPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecPath::add(self : Nlpembeddoc2vecPath, other : Nlpembeddoc2vecPath) -> Nlpembeddoc2vecPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Nlpembeddoc2vecPath::copy(self : Nlpembeddoc2vecPath) -> Nlpembeddoc2vecPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecPath::fill(self : Nlpembeddoc2vecPath, v : Double) -> Nlpembeddoc2vecPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecPath::min(self : Nlpembeddoc2vecPath) -> Double { @_common.min(self.data) }

pub fn Nlpembeddoc2vecPath::max(self : Nlpembeddoc2vecPath) -> Double { @_common.max(self.data) }

pub fn Nlpembeddoc2vecPath::to_string(self : Nlpembeddoc2vecPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_cluster_make(size : Int) -> Nlpembeddoc2vecCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Nlpembeddoc2vecCluster::len(self : Nlpembeddoc2vecCluster) -> Int { self.size }

pub fn Nlpembeddoc2vecCluster::get(self : Nlpembeddoc2vecCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Nlpembeddoc2vecCluster::set(self : Nlpembeddoc2vecCluster, i : Int, v : Double) -> Nlpembeddoc2vecCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecCluster::sum(self : Nlpembeddoc2vecCluster) -> Double { @_common.sum(self.data) }

pub fn Nlpembeddoc2vecCluster::mean(self : Nlpembeddoc2vecCluster) -> Double { @_common.mean(self.data) }

pub fn Nlpembeddoc2vecCluster::scale(self : Nlpembeddoc2vecCluster, f : Double) -> Nlpembeddoc2vecCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecCluster::add(self : Nlpembeddoc2vecCluster, other : Nlpembeddoc2vecCluster) -> Nlpembeddoc2vecCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Nlpembeddoc2vecCluster::copy(self : Nlpembeddoc2vecCluster) -> Nlpembeddoc2vecCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecCluster::fill(self : Nlpembeddoc2vecCluster, v : Double) -> Nlpembeddoc2vecCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecCluster::min(self : Nlpembeddoc2vecCluster) -> Double { @_common.min(self.data) }

pub fn Nlpembeddoc2vecCluster::max(self : Nlpembeddoc2vecCluster) -> Double { @_common.max(self.data) }

pub fn Nlpembeddoc2vecCluster::to_string(self : Nlpembeddoc2vecCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_model_make(size : Int) -> Nlpembeddoc2vecModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Nlpembeddoc2vecModel::len(self : Nlpembeddoc2vecModel) -> Int { self.size }

pub fn Nlpembeddoc2vecModel::get(self : Nlpembeddoc2vecModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Nlpembeddoc2vecModel::set(self : Nlpembeddoc2vecModel, i : Int, v : Double) -> Nlpembeddoc2vecModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecModel::sum(self : Nlpembeddoc2vecModel) -> Double { @_common.sum(self.data) }

pub fn Nlpembeddoc2vecModel::mean(self : Nlpembeddoc2vecModel) -> Double { @_common.mean(self.data) }

pub fn Nlpembeddoc2vecModel::scale(self : Nlpembeddoc2vecModel, f : Double) -> Nlpembeddoc2vecModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecModel::add(self : Nlpembeddoc2vecModel, other : Nlpembeddoc2vecModel) -> Nlpembeddoc2vecModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Nlpembeddoc2vecModel::copy(self : Nlpembeddoc2vecModel) -> Nlpembeddoc2vecModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecModel::fill(self : Nlpembeddoc2vecModel, v : Double) -> Nlpembeddoc2vecModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecModel::min(self : Nlpembeddoc2vecModel) -> Double { @_common.min(self.data) }

pub fn Nlpembeddoc2vecModel::max(self : Nlpembeddoc2vecModel) -> Double { @_common.max(self.data) }

pub fn Nlpembeddoc2vecModel::to_string(self : Nlpembeddoc2vecModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_layer_make(size : Int) -> Nlpembeddoc2vecLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Nlpembeddoc2vecLayer::len(self : Nlpembeddoc2vecLayer) -> Int { self.size }

pub fn Nlpembeddoc2vecLayer::get(self : Nlpembeddoc2vecLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Nlpembeddoc2vecLayer::set(self : Nlpembeddoc2vecLayer, i : Int, v : Double) -> Nlpembeddoc2vecLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecLayer::sum(self : Nlpembeddoc2vecLayer) -> Double { @_common.sum(self.data) }

pub fn Nlpembeddoc2vecLayer::mean(self : Nlpembeddoc2vecLayer) -> Double { @_common.mean(self.data) }

pub fn Nlpembeddoc2vecLayer::scale(self : Nlpembeddoc2vecLayer, f : Double) -> Nlpembeddoc2vecLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecLayer::add(self : Nlpembeddoc2vecLayer, other : Nlpembeddoc2vecLayer) -> Nlpembeddoc2vecLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Nlpembeddoc2vecLayer::copy(self : Nlpembeddoc2vecLayer) -> Nlpembeddoc2vecLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecLayer::fill(self : Nlpembeddoc2vecLayer, v : Double) -> Nlpembeddoc2vecLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecLayer::min(self : Nlpembeddoc2vecLayer) -> Double { @_common.min(self.data) }

pub fn Nlpembeddoc2vecLayer::max(self : Nlpembeddoc2vecLayer) -> Double { @_common.max(self.data) }

pub fn Nlpembeddoc2vecLayer::to_string(self : Nlpembeddoc2vecLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_buffer_make(size : Int) -> Nlpembeddoc2vecBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Nlpembeddoc2vecBuffer::len(self : Nlpembeddoc2vecBuffer) -> Int { self.size }

pub fn Nlpembeddoc2vecBuffer::get(self : Nlpembeddoc2vecBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Nlpembeddoc2vecBuffer::set(self : Nlpembeddoc2vecBuffer, i : Int, v : Double) -> Nlpembeddoc2vecBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecBuffer::sum(self : Nlpembeddoc2vecBuffer) -> Double { @_common.sum(self.data) }

pub fn Nlpembeddoc2vecBuffer::mean(self : Nlpembeddoc2vecBuffer) -> Double { @_common.mean(self.data) }

pub fn Nlpembeddoc2vecBuffer::scale(self : Nlpembeddoc2vecBuffer, f : Double) -> Nlpembeddoc2vecBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecBuffer::add(self : Nlpembeddoc2vecBuffer, other : Nlpembeddoc2vecBuffer) -> Nlpembeddoc2vecBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Nlpembeddoc2vecBuffer::copy(self : Nlpembeddoc2vecBuffer) -> Nlpembeddoc2vecBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecBuffer::fill(self : Nlpembeddoc2vecBuffer, v : Double) -> Nlpembeddoc2vecBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecBuffer::min(self : Nlpembeddoc2vecBuffer) -> Double { @_common.min(self.data) }

pub fn Nlpembeddoc2vecBuffer::max(self : Nlpembeddoc2vecBuffer) -> Double { @_common.max(self.data) }

pub fn Nlpembeddoc2vecBuffer::to_string(self : Nlpembeddoc2vecBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_cursor_make(size : Int) -> Nlpembeddoc2vecCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Nlpembeddoc2vecCursor::len(self : Nlpembeddoc2vecCursor) -> Int { self.size }

pub fn Nlpembeddoc2vecCursor::get(self : Nlpembeddoc2vecCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Nlpembeddoc2vecCursor::set(self : Nlpembeddoc2vecCursor, i : Int, v : Double) -> Nlpembeddoc2vecCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecCursor::sum(self : Nlpembeddoc2vecCursor) -> Double { @_common.sum(self.data) }

pub fn Nlpembeddoc2vecCursor::mean(self : Nlpembeddoc2vecCursor) -> Double { @_common.mean(self.data) }

pub fn Nlpembeddoc2vecCursor::scale(self : Nlpembeddoc2vecCursor, f : Double) -> Nlpembeddoc2vecCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecCursor::add(self : Nlpembeddoc2vecCursor, other : Nlpembeddoc2vecCursor) -> Nlpembeddoc2vecCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Nlpembeddoc2vecCursor::copy(self : Nlpembeddoc2vecCursor) -> Nlpembeddoc2vecCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecCursor::fill(self : Nlpembeddoc2vecCursor, v : Double) -> Nlpembeddoc2vecCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecCursor::min(self : Nlpembeddoc2vecCursor) -> Double { @_common.min(self.data) }

pub fn Nlpembeddoc2vecCursor::max(self : Nlpembeddoc2vecCursor) -> Double { @_common.max(self.data) }

pub fn Nlpembeddoc2vecCursor::to_string(self : Nlpembeddoc2vecCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_view_make(size : Int) -> Nlpembeddoc2vecView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Nlpembeddoc2vecView::len(self : Nlpembeddoc2vecView) -> Int { self.size }

pub fn Nlpembeddoc2vecView::get(self : Nlpembeddoc2vecView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Nlpembeddoc2vecView::set(self : Nlpembeddoc2vecView, i : Int, v : Double) -> Nlpembeddoc2vecView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecView::sum(self : Nlpembeddoc2vecView) -> Double { @_common.sum(self.data) }

pub fn Nlpembeddoc2vecView::mean(self : Nlpembeddoc2vecView) -> Double { @_common.mean(self.data) }

pub fn Nlpembeddoc2vecView::scale(self : Nlpembeddoc2vecView, f : Double) -> Nlpembeddoc2vecView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecView::add(self : Nlpembeddoc2vecView, other : Nlpembeddoc2vecView) -> Nlpembeddoc2vecView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Nlpembeddoc2vecView::copy(self : Nlpembeddoc2vecView) -> Nlpembeddoc2vecView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecView::fill(self : Nlpembeddoc2vecView, v : Double) -> Nlpembeddoc2vecView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecView::min(self : Nlpembeddoc2vecView) -> Double { @_common.min(self.data) }

pub fn Nlpembeddoc2vecView::max(self : Nlpembeddoc2vecView) -> Double { @_common.max(self.data) }

pub fn Nlpembeddoc2vecView::to_string(self : Nlpembeddoc2vecView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_range_make(size : Int) -> Nlpembeddoc2vecRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Nlpembeddoc2vecRange::len(self : Nlpembeddoc2vecRange) -> Int { self.size }

pub fn Nlpembeddoc2vecRange::get(self : Nlpembeddoc2vecRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Nlpembeddoc2vecRange::set(self : Nlpembeddoc2vecRange, i : Int, v : Double) -> Nlpembeddoc2vecRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecRange::sum(self : Nlpembeddoc2vecRange) -> Double { @_common.sum(self.data) }

pub fn Nlpembeddoc2vecRange::mean(self : Nlpembeddoc2vecRange) -> Double { @_common.mean(self.data) }

pub fn Nlpembeddoc2vecRange::scale(self : Nlpembeddoc2vecRange, f : Double) -> Nlpembeddoc2vecRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecRange::add(self : Nlpembeddoc2vecRange, other : Nlpembeddoc2vecRange) -> Nlpembeddoc2vecRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Nlpembeddoc2vecRange::copy(self : Nlpembeddoc2vecRange) -> Nlpembeddoc2vecRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecRange::fill(self : Nlpembeddoc2vecRange, v : Double) -> Nlpembeddoc2vecRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecRange::min(self : Nlpembeddoc2vecRange) -> Double { @_common.min(self.data) }

pub fn Nlpembeddoc2vecRange::max(self : Nlpembeddoc2vecRange) -> Double { @_common.max(self.data) }

pub fn Nlpembeddoc2vecRange::to_string(self : Nlpembeddoc2vecRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_slice_make(size : Int) -> Nlpembeddoc2vecSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Nlpembeddoc2vecSlice::len(self : Nlpembeddoc2vecSlice) -> Int { self.size }

pub fn Nlpembeddoc2vecSlice::get(self : Nlpembeddoc2vecSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Nlpembeddoc2vecSlice::set(self : Nlpembeddoc2vecSlice, i : Int, v : Double) -> Nlpembeddoc2vecSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecSlice::sum(self : Nlpembeddoc2vecSlice) -> Double { @_common.sum(self.data) }

pub fn Nlpembeddoc2vecSlice::mean(self : Nlpembeddoc2vecSlice) -> Double { @_common.mean(self.data) }

pub fn Nlpembeddoc2vecSlice::scale(self : Nlpembeddoc2vecSlice, f : Double) -> Nlpembeddoc2vecSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecSlice::add(self : Nlpembeddoc2vecSlice, other : Nlpembeddoc2vecSlice) -> Nlpembeddoc2vecSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Nlpembeddoc2vecSlice::copy(self : Nlpembeddoc2vecSlice) -> Nlpembeddoc2vecSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecSlice::fill(self : Nlpembeddoc2vecSlice, v : Double) -> Nlpembeddoc2vecSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Nlpembeddoc2vecSlice::min(self : Nlpembeddoc2vecSlice) -> Double { @_common.min(self.data) }

pub fn Nlpembeddoc2vecSlice::max(self : Nlpembeddoc2vecSlice) -> Double { @_common.max(self.data) }

pub fn Nlpembeddoc2vecSlice::to_string(self : Nlpembeddoc2vecSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

